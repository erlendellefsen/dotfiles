#!/usr/bin/env bash
# Claude Code status line
# Layout: [path git] [turns time cost] [context model]

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
effort=$(jq -r '.effortLevel // empty' "$HOME/.claude/settings.json" 2>/dev/null)
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
api_ms=$(echo "$input" | jq -r '.cost.total_api_duration_ms // 0')
transcript=$(echo "$input" | jq -r '.transcript_path // empty')

# --- Location ---

# Path (blue) — collapse $HOME to ~
short_cwd="${cwd/#$HOME/~}"
printf '\033[34m%s\033[0m' "$short_cwd"

# Git (grey + cyan arrows)
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" -c core.fsmonitor=false branch --show-current 2>/dev/null)
  [ -z "$branch" ] && branch="@$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null)"

  dirty=""
  if ! git -C "$cwd" -c core.fsmonitor=false diff --quiet 2>/dev/null \
    || ! git -C "$cwd" -c core.fsmonitor=false diff --cached --quiet 2>/dev/null; then
    dirty="*"
  fi

  ahead=$(git -C "$cwd" -c core.fsmonitor=false rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
  behind=$(git -C "$cwd" -c core.fsmonitor=false rev-list --count HEAD..@{u} 2>/dev/null || echo "0")
  arrows=""
  [ "$behind" -gt 0 ] && arrows="${arrows}⇣"
  [ "$ahead" -gt 0 ] && arrows="${arrows}⇡"

  # Diff stats (green additions, red deletions)
  diff_stat=$(git -C "$cwd" -c core.fsmonitor=false diff --shortstat HEAD 2>/dev/null)
  diff_add=""
  diff_del=""
  if [ -n "$diff_stat" ]; then
    add_num=$(echo "$diff_stat" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+')
    del_num=$(echo "$diff_stat" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+')
    [ -n "$add_num" ] && diff_add="$add_num"
    [ -n "$del_num" ] && diff_del="$del_num"
  fi

  printf ' \033[90m%s%s' "$branch" "$dirty"
  [ -n "$arrows" ] && printf ' \033[36m%s' "$arrows"
  if [ -n "$diff_add" ] || [ -n "$diff_del" ]; then
    printf ' '
    [ -n "$diff_add" ] && printf '\033[32m+%s\033[0m' "$diff_add"
    [ -n "$diff_add" ] && [ -n "$diff_del" ] && printf ' '
    [ -n "$diff_del" ] && printf '\033[31m-%s\033[0m' "$diff_del"
  fi
  printf '\033[0m'
fi

printf ' \033[90m│\033[0m'

# --- Session activity ---

# Turn count (magenta) — count user messages in JSONL transcript
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  turns=$(grep -c '"type":"user"' "$transcript" 2>/dev/null)
  if [ -n "$turns" ] && [ "$turns" -gt 0 ]; then
    printf ' \033[35m↻ %s\033[0m' "$turns"
  fi
fi

# Active time (cyan) — time Claude spent working, not idle time
if [ "$api_ms" -gt 0 ]; then
  api_sec=$((api_ms / 1000))
  mins=$((api_sec / 60))
  secs=$((api_sec % 60))
  if [ "$mins" -gt 0 ]; then
    printf ' \033[36m%dm %ds\033[0m' "$mins" "$secs"
  else
    printf ' \033[36m%ds\033[0m' "$secs"
  fi
fi

# Cost (green)
if [ "$(echo "$cost > 0" | bc 2>/dev/null)" = "1" ]; then
  cost_fmt=$(printf '%.2f' "$cost")
  printf ' \033[32m$%s\033[0m' "$cost_fmt"
fi

printf ' \033[90m│\033[0m'

# --- System state ---

# Context window (cyan < 50%, yellow < 80%, red >= 80%)
if [ -n "$used_pct" ]; then
  used_int=$(printf '%.0f' "$used_pct")
  if [ "$used_int" -ge 80 ]; then
    ctx_color='\033[31m'
  elif [ "$used_int" -ge 50 ]; then
    ctx_color='\033[33m'
  else
    ctx_color='\033[36m'
  fi
  printf " ${ctx_color}ctx:%d%%\033[0m" "$used_int"
fi

# Model (yellow)
printf ' \033[33m%s\033[0m' "$model"

# Effort level — colored per level, gradient for xhigh/max
if [ -n "$effort" ] && [ "$effort" != "normal" ]; then
  case "$effort" in
    low)
      printf ' \033[33m%s\033[0m' "$effort"
      ;;
    medium)
      printf ' \033[92m%s\033[0m' "$effort"
      ;;
    high)
      printf ' \033[94m%s\033[0m' "$effort"
      ;;
    xhigh|max)
      if [ "$effort" = "xhigh" ]; then
        palette=(141 105 75 117 75 105)
      else
        palette=(196 208 226 46 51 21 129)
      fi
      len=${#palette[@]}
      offset=$(date +%s 2>/dev/null || echo 0)
      printf ' '
      i=0
      while [ $i -lt ${#effort} ]; do
        ch="${effort:$i:1}"
        color="${palette[$(((i + offset) % len))]}"
        printf '\033[38;5;%sm%s' "$color" "$ch"
        i=$((i+1))
      done
      printf '\033[0m'
      ;;
    *)
      printf ' \033[90m%s\033[0m' "$effort"
      ;;
  esac
fi

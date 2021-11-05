LOKI_URL="http://localhost:3100"
LOGCLI=~/.go/bin/logcli
PROMTAIL=./promtail
PROMTAIL_CONFIG=./promtail-config.yaml

if hash stdbuf 2>/dev/null; then
    _bufcmd(){
      stdbuf -o0 awk '!seen[$0]++'
    }
else
    _bufcmd(){
      gstdbuf -o0 awk '!seen[$0]++'
    }
fi

__fzf_history__() {
  local output
  output=$(
    $LOGCLI query '{job="bash"}' --addr=$LOKI_URL --limit=50000 --batch=1000 --since=4380h -o raw --quiet | _bufcmd |
      FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m " $(__fzfcmd) --query "$READLINE_LINE"
      ) || return
  READLINE_LINE=${output#*$'\t'}
  if [ -z "$READLINE_POINT" ]; then
    echo "$READLINE_LINE"
  else
    READLINE_POINT=0x7fffffff
  fi
}

function _send_to_loki {
  if [[ -v PRIVATE ]]; then
    echo "PRIVATE set, not sending to loki-shell"
    return 0
  fi
	(HISTTIMEFORMAT= builtin history 1 | sed 's/^ *\([0-9]*\)\** *//' |
    $PROMTAIL \
    -config.file="$PROMTAIL_CONFIG" \
    --stdin -server.disable=true -log.level=error \
    --client.external-labels=host=$HOSTNAME 2>&1 | logger -t loki-shell-promtail &)
}
[[ $PROMPT_COMMAND =~ _send_to_loki ]] || PROMPT_COMMAND="_send_to_loki;${PROMPT_COMMAND:-:}"

alias hist="$LOGCLI --addr=$LOKI_URL --quiet"

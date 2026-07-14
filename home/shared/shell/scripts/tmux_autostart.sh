#!/bin/bash

set-checkpoint() {
  local checkpoint_dir="$HOME/.config/tmux-autostart"
  local checkpoint_file="$checkpoint_dir/checkpoint_dir"

  if [[ ! -d "$checkpoint_dir" ]]; then
    mkdir -p "$checkpoint_dir" 2>/dev/null
    if [[ $? -ne 0 ]]; then
      echo "Error: gagal membuat direktori $checkpoint_dir" >&2
      return 1
    fi
    echo "Direktori checkpoint dibuat: $checkpoint_dir"
  fi

  if pwd >"$checkpoint_file" 2>/dev/null; then
    echo "Checkpoint diset ke: $(pwd)"
  else
    echo "Error: gagal menulis checkpoint ke $checkpoint_file" >&2
    return 1
  fi
}

tmux_init() {
  if [[ -z "$TMUX" ]] && [[ $- == *i* ]] && [[ -t 1 ]]; then
    SESSION_NAME="main"
    CHECKPOINT_FILE="$HOME/.config/tmux-autostart/checkpoint_dir"

    if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
      echo -n "run new tmux session? [N/y]: "
      read -r choice
      case "$choice" in
      y | Y)
        tmux new-session
        ;;
      *)
        tmux attach-session -t "$SESSION_NAME"
        ;;
      esac
    else
      START_DIR="$HOME"

      if [[ -f "$CHECKPOINT_FILE" ]] && [[ -r "$CHECKPOINT_FILE" ]] && [[ -s "$CHECKPOINT_FILE" ]]; then
        local_checkpoint=$(cat "$CHECKPOINT_FILE" 2>/dev/null)
        if [[ -n "$local_checkpoint" ]] && [[ -d "$local_checkpoint" ]]; then
          START_DIR="$local_checkpoint"
        fi
      fi

      tmux new-session -d -s "$SESSION_NAME" -n "$EDITOR" -c "$START_DIR"
      tmux send-keys -t "$SESSION_NAME:$EDITOR" "$EDITOR" C-m
      tmux new-window -t "$SESSION_NAME" -n "shell"
      tmux select-window -t "$SESSION_NAME:$EDITOR"
      tmux attach-session -t "$SESSION_NAME"
    fi
  fi
}

_shortcut_init_widget() {
  BUFFER="tmux_init"
  zle accept-line
}
zle -N _shortcut_init_widget

bindkey "^A" _shortcut_init_widget

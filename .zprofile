# ~/.zprofile
#

# Rust/Cargo
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Local bin environment
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# Timezone
export TZ='Asia/Seoul'

# Auto-start X on tty1
if [[ -z "$DISPLAY" && "$(tty)" = "/dev/tty1" ]]; then
  exec startx
fi

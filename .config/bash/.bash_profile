if [[ "$OSTYPE" == "darwin"* ]]; then
	# needed for brew
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

. "$HOME/.cargo/env"

export PATH="/Users/nelson/.local/share/solana/install/active_release/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=$(which chromium)
export PATH="/opt/homebrew/bin:$PATH"

export PATH="$PATH:/Users/nelson/.foundry/bin"
export LESS="iMRS"
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

# opam configuration
# [[ ! -r /Users/nelson/.opam/opam-init/init.zsh ]] || source /Users/nelson/.opam/opam-init/init.zsh >/dev/null 2>/dev/null

if [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi

if [ -r ~/.aliases ]; then
	source ~/.aliases
fi

export BAT_THEME="ansi"

export XDG_CONFIG_HOME="$HOME"/.config
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

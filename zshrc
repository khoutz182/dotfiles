# zmodload zsh/zprof


ZNAP_DIR=~/src/zsh-snap
ZNAP_FILE="${ZNAP_DIR}/znap.zsh"
[[ -f $ZNAP_FILE ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $ZNAP_DIR

source $ZNAP_FILE

# znap prompt sindresorhus/pure

# znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
# znap source zsh-users/zsh-syntax-highlighting

for config (~/.config/zsh/*.zsh) source $config

source "$HOME/.cargo/env"
# nvm stuffs :-(

# zprof


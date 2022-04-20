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
export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# zprof


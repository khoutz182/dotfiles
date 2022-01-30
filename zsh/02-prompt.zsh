
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:git:*' formats '%b|%c|%u'
zstyle ':vcs_info:git*' formats "%f(%F{#$themeColors[color0D]}%b%f)"

precmd() {
    vcs_info
}

# Must be single quoted strings for substitution to work
setopt prompt_subst
PROMPT='%F{#$themeColors[color0D]}%1~ %F{#$themeColors[color0A]}%f '
RPROMPT='%(?..%F{#$themeColors[color08]}[%?]) %F{#$themeColors[color0A]}${vcs_info_msg_0_}%f'

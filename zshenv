
export EDITOR=nvim

export ZSH_AUTOSUGGEST_MANUAL_REBIND="true"

# https://unix.stackexchange.com/questions/197839/why-does-exporting-vim-as-editor-in-zsh-disable-keyboard-shortcuts
bindkey -e # emacs

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# export GITHUB_TOKEN={{githubToken}}
export POLYBAR_GITHUB_TOKEN={{polybar_ghToken}}
export OPENWEATHERMAP_KEY={{openweathermapKey}}
export JIRA_API_TOKEN={{jiraToken}}

export COLOR_00="#{{color00}}"
export COLOR_01="#{{color01}}"
export COLOR_02="#{{color02}}"
export COLOR_03="#{{color03}}"
export COLOR_04="#{{color04}}"
export COLOR_05="#{{color05}}"
export COLOR_06="#{{color06}}"
export COLOR_07="#{{color07}}"
export COLOR_08="#{{color08}}"
export COLOR_09="#{{color09}}"
export COLOR_0A="#{{color0A}}"
export COLOR_0B="#{{color0B}}"
export COLOR_0C="#{{color0C}}"
export COLOR_0D="#{{color0D}}"
export COLOR_0E="#{{color0E}}"
export COLOR_0F="#{{color0F}}"

# Darwin or Linux
export os=$(uname -s)


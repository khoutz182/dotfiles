export LANG=en_US.UTF-8
export PATH="$PATH:$(yarn global bin)"

# Colors
declare -A themeColors

themeColors=(
    [color00]={{color00}}
    [color01]={{color01}}
    [color02]={{color02}}
    [color03]={{color03}}
    [color04]={{color04}}
    [color05]={{color05}}
    [color06]={{color06}}
    [color07]={{color07}}
    [color08]={{color08}}
    [color09]={{color09}}
    [color0A]={{color0A}}
    [color0B]={{color0B}}
    [color0C]={{color0C}}
    [color0D]={{color0D}}
    [color0E]={{color0E}}
    [color0F]={{color0F}}
)

eval "$(zoxide init zsh)"

#!/bin/zsh

set -e

export PATH=$PATH_ADDITION:$PATH

GAL_PROMPT_PREFIX="\e[34m✡\e[m  "

function type() {
  printf $GAL_PROMPT_PREFIX
  echo -n " "
  text_to_write="$*"
  for (( i=0; i<${#text_to_write}; i++ )); do
    printf "${text_to_write:$i:1}"
    sleep 0.0$[(10+(-2+RANDOM%5))/2]
  done
  printf "\n"
}

type 'eval "$(fnm env)"'
eval "$(fnm env)"

type 'fnm --version'
fnm --version

type 'cat .node-version'
cat .node-version

type 'fnm install'
fnm install

type 'fnm use'
fnm use

type 'node -v'
node -v

sleep 2
echo ""

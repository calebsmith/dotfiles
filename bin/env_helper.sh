#!/bin/bash

# Ensure godotenv is installed
if ! command -v godotenv &> /dev/null; then
    go get github.com/joho/godotenv/cmd/godotenv
fi

if [ -z "ENVS_ROOT" ]; then
 echo "Set ENVS_ROOT to a folder with .env files for autocompletion functionality"
fi

function envshell() {
    # Gets the name of the package
    if [[ -z "$1" ]] ; then
        godotenv "$SHELL"
    else
        godotenv -f "$ENVS_ROOT/$1" "$SHELL"
    fi
}

#Completions for envs
_env_helper_completions()
{
_script=$(ls $ENVS_ROOT)

  local cur
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${_script}" -- ${cur}) )

  return 0
}
complete -o nospace -F _env_helper_completions envshell

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="fino-time"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export GOROOT=/usr/lib/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export PATH=$PATH:/opt/nvim-linux64/bin
export PATH=$PATH:/home/chaykovski/.local/bin
export LD_LIBRARY_PATH=/usr/local/cuda-12.5/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PATH="$HOME/.tmuxifier/bin:$PATH"

eval "$(tmuxifier init -)"

alias ssh='TERM=xterm-256color ssh'

autoload -U compinit
compinit -i 
source /home/chaykovski/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


SSH_ENV="$HOME/.ssh/environment"

function run_ssh_env {
  . "${SSH_ENV}" > /dev/null
}

function start_ssh_agent {
  echo "Initializing new SSH agent..."
  ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo "succeeded"
  chmod 600 "${SSH_ENV}"

  run_ssh_env;
  ssh-add ~/.ssh/github_ssh

  echo "Loading keys into ssh-agent..."
}

if [ -f "${SSH_ENV}" ]; then
  run_ssh_env;
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_ssh_agent;
  }
else
  start_ssh_agent;
fi

# zsh parameter completion for the dotnet CLI

_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet

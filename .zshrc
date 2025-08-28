# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl rails)

eval "$(rbenv init - zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/gradle@7/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

alias be="bundle exec"

cccd() {
  ENV=cccd-$1
  POD=$(kubectl get pod -n $ENV  --field-selector=status.phase==Running -o jsonpath="{.items[0].metadata.name}")
  echo Logging into $POD in the $ENV namespace
  kubectl exec --stdin --tty -n $ENV $POD  -- /bin/sh
}

pf() {
  if [[ $1 == "ccr" ]] then
    ENV=laa-crown-court-remuneration-$2
  fi

  if [[ $1 == "cclf" ]] then
    ENV=laa-crown-court-litigator-fees-$2
  fi

  echo Connecting to the database in the $ENV namespace
  kubectl -n $ENV port-forward port-forward-pod 1521:1521 
}

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /Users/mark.whitaker/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
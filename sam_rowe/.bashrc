[[ -f ${HOME}/.bash-local/init ]] && source ${HOME}/.bash-local/init
COMPLETIONFILE=${COMPLETIONFILE:=/etc/bash_completion}
source ${HOME}/.bash/env
source ${HOME}/.bash/aliases
source ${HOME}/.bash/func
[[ -n "${PS1}" ]] && source ${HOME}/.bash/prompt

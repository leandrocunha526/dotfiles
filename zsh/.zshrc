echo $(lsb_release -i -s) $(lsb_release -r) "(I use Arch btw)" $(uname -r)

# history autocomplete section
# initialize autocompletion
autoload -U compinit
compinit

# history setup
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=1000
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# powerline
powerline-daemon -q
. /usr/share/powerline/bindings/zsh/powerline.zsh

# sources
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

# aliases
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'

# exports

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Export Ruby environment
export GEM_HOME=~/.gems

# android/flutter
#export ANDROID_HOME=~/Android/Sdk
#export PATH=$PATH:$ANDROID_HOME/emulator
#export PATH=$PATH:$ANDROID_HOME/tools
#export PATH=$PATH:$ANDROID_HOME/tools/bin
#export PATH=$PATH:$ANDROID_HOME/platform-tools

alias tree="tree -aC"

# Debian packaging
alias uscan-check="uscan --verbose --report"
export DEBFULLNAME="Leandro Cunha"
export DEBEMAIL="leandrocunha016@gmail.com"

# sbuild
alias gbpbuild='gbp buildpackage --git-builder=sbuild -v --no-clean-source'
alias bp="gbp buildpackage --git-builder=sbuild -v --source-only-changes"

# Java
#export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

# editor
export EDITOR=vim

PATH="/home/arch/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/arch/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/arch/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/arch/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/arch/perl5"; export PERL_MM_OPT;

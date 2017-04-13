# My own personal navigation shortcuts, see environment-variables file for
# variable definitions.
cto() {
  case "$1" in
    "code" | "base")       cd $CODE_BASE_DIR ;;
    "vag" | "vagrant")     cd $VAGRANT_DIR  ;;
    "files")               cls $HOME/.files ;;
    "apache")              cls /etc/apache2/ ;;
    "nginx")               cls /etc/nginx/ ;;
    "php")                 cls /etc/php5/ ;;
    "logs")                cls /var/log ;;
    *)                     cd $1 ;;
  esac
}
complete -W "code base vagrant zf public sass legacy angular application controller config website istock unittest uwebsite uistock files apache nginx php logs" cto
#
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi

alias ll='ls -alFh'
alias la='ls -Ah'
alias l='ls -CFh'

# cd and list it's files
cls() { cd "$1"; ls;}

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

alias c="clear"

alias reboot='sudo reboot'

# Apt-get shortcuts
alias apt-get='apt-fast'
alias update='sudo apt-fast update'
alias upgrade='sudo apt-fast -y upgrade'
alias upup='update && upgrade -y'
alias install='sudo apt-fast -y install'
alias search='apt-cache search'

# Audio volume
alias volume="amixer get Master | sed '1,4 d' | cut -d [ -f 2 | cut -d ] -f 1"

# Start calc with math support
alias bc='bc -l'

# Make mkdir create parent directories if necessary
alias mkdir='mkdir -pv'

# Show open ports
alias ports='netstat -tulanp'
# Shor ip info
alias ipinfo="echo -n 'External: ' && curl ifconfig.co && echo -n 'Internal: ' && hostname -I"

# Backup a file like a scrub living in a world without file versioning
backup() { cp "$1"{,.bak};}

# Memory info
alias meminfo='free -m -l -t'

# Get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Get server cpu info 
alias cpuinfo="lscpu"

# Get GPU ram
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

alias df='df -H'
alias du='du -ch'

alias top='htop'

# quick output of system info
myinfo () {
  printf "CPU: "
    cat /proc/cpuinfo | grep "model name" | head -1 | awk '{ for (i = 4; i <= NF; i++) printf "%s ", $i }'
    printf "\n"

    cat /etc/issue | awk '{ printf "OS: %s %s %s %s | " , $1 , $2 , $3 , $4 }'
    uname -a | awk '{ printf "Kernel: %s " , $3 }'
    uname -m | awk '{ printf "%s | " , $1 }'
    printf "\n"
    uptime | awk '{ printf "Uptime: %s %s %s", $3, $4, $5 }' | sed 's/,//g'
    printf "\n"
    cputemp | head -1 | awk '{ printf "%s %s %s\n", $1, $2, $3 }'
    cputemp | tail -1 | awk '{ printf "%s %s %s\n", $1, $2, $3 }'
}


extract() { 
  if [ -f $1 ] ; then 
    case $1 in 
      *.tar.bz2)   tar xjf $1     ;; 
      *.tar.gz)    tar xzf $1     ;; 
      *.bz2)       bunzip2 $1     ;; 
      *.rar)       unrar e $1     ;; 
      *.gz)        gunzip $1      ;; 
      *.tar)       tar xf $1      ;; 
      *.tbz2)      tar xjf $1     ;; 
      *.tgz)       tar xzf $1     ;; 
      *.zip)       unzip $1       ;; 
      *.Z)         uncompress $1  ;; 
      *.7z)        7z x $1        ;; 
      *)     echo "'$1' cannot be extracted via extract()" ;; 
    esac 
  else 
    echo "'$1' is not a valid file" 
  fi 
}

pwdfor() {
  lpass ls | ag $1 | sed -r 's/.*id: ([0-9]+).*/\1/g' | xargs lpass show
}

alias nodeenv="nodenv"

alias ngninx-restart="sudo service nginx restart"
alias nginx-restart="sudo service nginx restart"

alias acl="arty cluster list --region=us-west-1"
alias acd="arty cluster describe --region=us-west-1"
alias acc="arty cluster create --region=us-west-1"
alias acs="arty cluster security --region=us-west-1 --open"
alias acrm="arty cluster delete --region=us-west-1"

get_jenkins_stream() {
  ssh $1  -- "/opt/morpheus/ffmpeg/ffmpeg -f x11grab -r 30 -video_size 1920x1080 -i :1 -qscale 0.1 -vcodec mpeg4 -f matroska - "| vlc -
}

alias lcd=changeDirectory
changeDirectory () {
  cd $1; ls -la
}

alias ag="ag --color-match=31"

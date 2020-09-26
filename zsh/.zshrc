export ZSH="/Users/ewelander/.oh-my-zsh"
ZSH_DISABLE_COMPFIX=true

ZSH_THEME=simple
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=1000
HISTFILESIZE=1000
plugins=(git copyfile)
source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='vim'
DEFAULT_USER=erikwelander
prompt_context(){}

# Set Dev HOME's
HOMEBREW_BIN=/usr/local/bin
CHROME_BIN="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
export JAVA_HOME=$(/usr/libexec/java_home -v 11);
export MAVEN_HOME="/usr/local/Cellar/atlassian-plugin-sdk/8.0.16/libexec/apache-maven-3.5.4"
export PATH="$HOMEBREW_BIN:$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"

# Atlas / Jira
export INSIGHT_JIRA_VERSION="--version 8.4.0"
# --jvm-debug-port 5006
BUILD_START_SKIP_TESTS="-DskipTests=true -DskipNpmBuild=true"
BUILD_PACKAGE_SKIP_TESTS="-DskipTests=true -DskipNpmBuild=true"

# Node version manager
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


function atl-d() { atlas-debug $INSIGHT_JIRA_VERSION }
function apg() { atlas-package $BUILD_NUM_THREADS $BUILD_PACKAGE_SKIP_TESTS -U }
function apu() { atlas-clean && atlas-mvn -U install }

function aws-login() { aws ecr get-login-password | docker login --username AWS --password-stdin asd.amazonaws.com }
function gchrome() { "open -a 'Google Chrome'" }
function ff() { "open -a 'Firefox'" }


function reload() { source ~/.zshrc }
function remove-docker-containers() { docker rm -vf $(docker ps -a -q) }
function remove-docker-images() { docker rmi -f $(docker images -a -q) }
function git-reset-author() { git commit --amend --reset-author --no-edit }

function cd() { builtin cd "$@" && ls; }
function ca() { bat "$@"; }
function rmr() { rm -rf "$@"; }
function cpr() { cp -r "$@"; }

function jcurl() { curl "$@" | json_pp; }

function free-port() { kill "$(lsof -t -i :$1)"; }
function kill-port() { kill -kill "$(lsof -t -i :$1)"; }

neofetch

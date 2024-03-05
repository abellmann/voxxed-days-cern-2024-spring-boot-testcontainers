# required for testcontainers with java
# without it you get connection refused for ryuk when starting
# testcontainer unit tests
# see https://java.testcontainers.org/supported_docker_environment/#colima",
export TESTCONTAINERS_HOST_OVERRIDE=$(rdctl shell ip a show rd0 | awk '/inet / {sub("/.*",""); print $2}')
echo TESTCONTAINERS_HOST_OVERRIDE=${TESTCONTAINERS_HOST_OVERRIDE}
# install kubectx and kubens as plugins for kubectl"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
krew install ctx
krew install ns
# autocompletion for kubectl
source <(kubectl completion zsh)

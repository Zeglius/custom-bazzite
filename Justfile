#!/usr/bin/env just

export DOCKER_HOST := "unix:///var/home/" + env("USER") + "/.lima/docker/sock/docker.sock"

_default:
    just --list

_init_docker_lima:
    #!/usr/bin/bash
    set -u
    exec > /dev/null
    STATUS=$(limactl list --format "{{'{{'}}.Name}}={{'{{'}}.Status}}" | awk -F '=' '/^docker/ {print $2}')
    STATUS=${STATUS,,}

    if [[ $STATUS != "running" ]]; then
        limactl start docker
    fi

act +ARGS="-n":
    just _init_docker_lima
    act {{ ARGS }}
#!/bin/sh
#
# Simple wrapper for executing ansible-galaxy and ansible-playbook.
#
# USAGE:
#    ansible-playbook-wrapper  [other ansible-playbook arguments]
#
# ENVIRONMENT VARIABLES:
#
#    - PIP_REQUIREMENTS:        pip requirements filename;
#                               default = "requirements.txt"
#    - ANSIBLE_REQUIREMENTS:    ansible requirements filename;
#                               default = "requirements.yml"
#    - DEPLOY_KEY               deploy key (private)

# Rotate ansible log if exist
if [ -f "ansible.log" ]; then
    DATE_LOG=$(date -d "$(head -1 ansible.log  | cut -d, -f1 )" +%Y%m%d-%H%M%S) 2>/dev/null
    if [ -n "$DATE_LOG" ]; then
        mv ansible.log ansible-${DATE_LOG}.log
        gzip ansible-${DATE_LOG}.log &
    fi
fi

# Optional deploy key
if [ ! -z "$DEPLOY_KEY" ] && [ ! -f "/root/.ssh/id_rsa" ]; then
    mkdir -p /root/.ssh/
    echo "${DEPLOY_KEY}" > /root/.ssh/id_rsa
    chmod 0600 /root/.ssh/id_rsa
fi

# Loadkey into ssh-agent if key exist
if [ -f "/root/.ssh/id_rsa" ]; then
    eval $(ssh-agent)
    ssh-add /root/.ssh/id_rsa
fi

# install pip requirements, if any
if [ -z "$PIP_REQUIREMENTS" ]; then
    PIP_REQUIREMENTS=requirements.txt
fi

if [ -f "$PIP_REQUIREMENTS" ]; then
    pip3 install --upgrade -r $PIP_REQUIREMENTS
fi


# install Galaxy roles, if any
if [ -z "$ANSIBLE_REQUIREMENTS" ]; then
    ANSIBLE_REQUIREMENTS=requirements.yml
fi

if [ -f "$ANSIBLE_REQUIREMENTS" ]; then
    ansible-galaxy install $ANSIBLE_GALAXY_PARAM -r $ANSIBLE_REQUIREMENTS
fi

exec "$@"

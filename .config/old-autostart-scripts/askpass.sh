#!/bin/sh

SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket" SSH_ASKPASS=/usr/bin/ksshaskpass ssh-add < /dev/null


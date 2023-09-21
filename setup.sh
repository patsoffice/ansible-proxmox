#!/bin/bash
set -euo pipefail

# Colours
BOLD='\033[1m'
RED='\033[91m'
GREEN='\033[92m'
YELLOW='\033[93m'
BLUE='\033[94m'
ENDC='\033[0m'

# Display a pretty header
echo
echo -e "${BOLD}proxmox setup (using Ansible)${ENDC}"
echo

# Install Ansible galaxy requirements
# ansible-galaxy install -r requirements.yml && \

# Perform the build
ansible-playbook --ask-vault-pass -i hosts.yml setup.yml "$@"

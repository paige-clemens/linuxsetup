#!/bin/bash

set -e

echo "=========================================="
echo "Linux/Mac Setup Script"
echo "=========================================="
echo ""

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    OS=$(uname -s)
fi

echo "Detected OS: $OS"
echo ""

# Install Ansible if not present
if ! command -v ansible-playbook &> /dev/null; then
    echo "Ansible not found. Installing..."
    case $OS in
        fedora|rhel|centos)
            sudo dnf install -y ansible
            ;;
        debian|ubuntu)
            sudo apt update
            sudo apt install -y ansible
            ;;
        darwin)
            if ! command -v brew &> /dev/null; then
                echo "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install ansible
            ;;
        *)
            echo "Unsupported OS: $OS"
            echo "Please install Ansible manually and run: ansible-playbook -c local -i hosts main.yml --ask-become-pass"
            exit 1
            ;;
    esac
else
    echo "Ansible is already installed."
fi

echo ""
echo "Installing required Ansible collections..."
ansible-galaxy collection install community.general

echo ""
echo "=========================================="
echo "Running Ansible playbook..."
echo "=========================================="
echo ""

ansible-playbook -c local -i hosts main.yml --ask-become-pass

echo ""
echo "=========================================="
echo "Setup complete!"
echo "=========================================="

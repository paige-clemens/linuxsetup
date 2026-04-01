# Linux/Mac Automated Development Environment

Automated setup for development environments on Mac, Debian/Ubuntu, and Fedora systems.

## Quick Start

The easiest way to run the setup is using the provided script:

```bash
./setup.sh
```

This script will:
1. Detect your operating system
2. Install Ansible if not already installed
3. Install required Ansible collections (community.general)
4. Run the playbook with sudo privileges

## Configuration

You can customize the following variables in `main.yml`:

- `git_user_name`: Your Git username (default: "Paige Clemens")
- `git_user_email`: Your Git email (default: "pclemens365@gmail.com")

Edit these values in the `vars` section at the top of `main.yml` before running the playbook.

## Mac Installation

1. Install Xcode Command Line Tools.
    ```bash
    xcode-select --install
    ```

2. Setup homebrew & ansible.
    ```bash
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update -v && brew upgrade -v
    brew install python3
    pip3 install ansible --user
    ~/Library/Python/$(python3 --version|awk {'print substr($2,1,3)'})/bin/ansible-playbook -c local -i hosts main.yml --ask-become-pass
    ```

## Debian/Ubuntu Installation

1. Install Ansible.
    ```bash
    sudo apt update
    sudo apt install -y ansible
    ```

2. Run the playbook.
    ```bash
    ansible-playbook -c local -i hosts main.yml --ask-become-pass
    ```

## Fedora Installation

1. Install Ansible.
    ```bash
    sudo dnf install -y ansible
    ```

2. Run the playbook.
    ```bash
    ansible-playbook -c local -i hosts main.yml --ask-become-pass
    ```

----

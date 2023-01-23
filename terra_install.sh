#!/usr/bin/env bash
echo "Install packages to verify HashiCorp's GPG signature, and install HashiCorp's Debian package repository."
$(sudo apt-get update && sudo apt-get install -y gnupg software-properties-common)


echo "Install the HashiCorp GPG key."
$(wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg)

echo "Verify the key's fingerprint."
$(gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint)

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

$(sudo apt update)
$(sudo apt-get install terraform)

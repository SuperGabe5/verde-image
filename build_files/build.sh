#!/bin/bash

set -ouex pipefail

### Install packages

# This installs packages from any enabled yum repo on the image.
# The 'dnf5 group install' command is correct for this newer build method.
dnf5 group install -y mate-desktop-environment

# Install a display manager. LightDM is a good choice for MATE.
dnf5 install -y lightdm lightdm-gtk-greeter

# This installs the 'tmux' package, which you already had.
dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# The next step configures the desktop environment
# It creates a file to tell the display manager (LightDM) to use MATE
mkdir -p /etc/lightdm/lightdm.conf.d
cat > /etc/lightdm/lightdm.conf.d/50-mate.conf <<EOF
[Seat:*]
user-session=mate
EOF

# This enables the display manager service to run on boot
systemctl enable lightdm.service

# This line from your original template enables the podman socket
systemctl enable podman.socket

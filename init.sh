#!/bin/bash
#Show title.
cat title
echo -e

#if user not exist.
if ! id -u $USERNAME >/dev/null 2>&1; then
    #Setting user account.
    adduser --gecos "" --disabled-password --allow-bad-names "$USERNAME"
    echo "$USERNAME:$PASSWORD" | chpasswd
    usermod -aG sudo "$USERNAME"
    echo "User $USERNAME create complete."

    #Setting workspace
    mkdir -p "/home/$USERNAME/workspace"
    sudo chown "$USERNAME":"$USERNAME" "/home/$USERNAME/workspace"
    cp "/serv/vscInit.sh" "/home/$USERNAME/workspace/vscInit.sh"
    chmod 777 "/home/$USERNAME/workspace/vscInit.sh"
    cp "/serv/vscInit_README.md" "/home/$USERNAME/workspace/vscInit_README.md"
    echo "$USERNAME's dir create complete."

    #Setting root password.
    echo "root:$SUDO_PASSWORD" | chpasswd
    echo "SUDO password setting complete."
fi

#Run ssh.
echo "Server is running..."
exec /usr/sbin/sshd -D
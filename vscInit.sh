#!/bin/bash

function title() {
    clear

    echo " ██████╗ ██████╗██████╗ ██████╗ ███████╗";
    echo "██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝";
    echo "██║     ██║     ██████╔╝██████╔╝███████╗";
    echo "██║     ██║     ██╔═══╝ ██╔═══╝ ╚════██║";
    echo "╚██████╗╚██████╗██║     ██║     ███████║";
    echo " ╚═════╝ ╚═════╝╚═╝     ╚═╝     ╚══════╝";    
}

function setup(){
    title

    sudo apt -y update | sudo apt -y upgrade
    sudo apt -y install curl wget git software-properties-common ca-certificates gnupg sudo

    main
}

function main() {
    title

    echo "Calou Service Initialization Builder Version 2.3"
    echo "Developed by Caloutw"
    
    echo -e

    echo "快速設置 : "
    echo "├─ (0) cert / 開啟SSL安全憑證 (Code-server)"
    echo "├─ (5) tmux / 安裝背景多任務視窗 (SSH)"
    echo -e
    echo "程式環境 : "
    echo "├─ (10) Node.js & npm / 安裝 nodejs"
    echo "├─ (11) Python & pip / 安裝 python"
    echo "├─ (12) openJDK / 安裝 java"
    echo "├─ (13) gcc / 安裝 c"
    echo -e
    echo "其他工具 : "
    echo "├─ (31) Zip / 安裝 zip"
    echo "├─ (32) RClone (Docker Privileged)"

    echo -e

    echo "(Ctrl + C) Exit"

    echo -e

    read -p "Enter your choice : " choice

    if [ $choice -eq 0 ]; then
        __INSTALL_CERT
    elif [ $choice -eq 5 ]; then
        __INSTALL_TMUX
    elif [ $choice -eq 10 ]; then
        __INSTALL_NODE
    elif [ $choice -eq 11 ]; then
        __INSTALL_PYTHON
    elif [ $choice -eq 12 ]; then
        __INSTALL_JAVA
    elif [ $choice -eq 13 ]; then
        __INSTALL_GCC
    elif [ $choice -eq 31 ]; then
        __INSTALL_ZIP
    elif [ $choice -eq 32 ]; then
        __INSTALL_RCLONE
    else
        title
        echo "Invalid choice!"
        sleep 2
        main
    fi
}

function __INSTALL_CERT() {
    title
    echo "Setting cert..."

    config_file="/config/.config/code-server/config.yaml"
    sed -i 's/cert: false/cert: true/' "$config_file"

    title
    echo "Setting Successfully!"
    echo "Please restart code-server."
    sleep 2

    main
}

function __INSTALL_TMUX(){
    title
    echo "Installing tmux..."

    sudo apt install tmux -y

    title
    echo "Installed Successfully!"
    sleep 2

    main
}


function __INSTALL_NODE() {
    title
    echo "Remove old version of node..."
    sudo apt-get remove -y libnode-dev
    sudo apt update -y
    sudo apt upgrade -y

    title
    echo "Nodejs version : "

    echo "├─ (1) 22.x"
    echo "├─ (2) 23.x"
    echo "└─ (3) 24.x"

    echo -e

    echo "(E) Exit"

    echo -e

    read -p "Enter your choice : " choice

    title
    echo "Installing Node.js & npm..."
    case $choice in
        1)
            sudo curl -sL https://deb.nodesource.com/setup_22.x | sudo -E bash -
            ;;
        2)
            sudo curl -sL https://deb.nodesource.com/setup_23.x | sudo -E bash -
            ;;
        3)
            sudo curl -sL https://deb.nodesource.com/setup_24.x | sudo -E bash -
            ;;
        E)
            main
            ;;
        *)
            echo "Invalid choice."
            sleep 2
            __INSTALL_NODE
            ;;
    esac

    sudo apt-get install -y -f nodejs

    title
    echo "Installing npm..."
    sudo apt-get install -y -f aptitude
    sudo aptitude install -y npm
    sudo npm install -g npm

    title
    echo "Installed Successfully!"
    sleep 2

    main
}

function __INSTALL_PYTHON() {
    title
    sudo apt install software-properties-common -y
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt update -y
    sudo apt upgrade -y

    title
    echo "Python version : "

    echo "├─ (1) 3.9.0"
    echo "├─ (2) 3.10.0"
    echo "├─ (3) 3.11.0"
    echo "└─ (4) 3.12.0"

    echo -e

    echo "(E) Exit"

    echo -e

    read -p "Enter your choice : " choice

    title

    echo "Installing Python..."
    case $choice in
        1)
            sudo apt install -y python3.9
            sudo apt install -y python3.9-venv python3-pip
            ;;
        2)
            sudo apt install -y python3.10
            sudo apt install -y python3.10-venv python3-pip
            ;;
        3)
            sudo apt install -y python3.11
            sudo apt install -y python3.11-venv python3-pip
            ;;
        4)
            sudo apt install -y python3.12
            sudo apt install -y python3.12-venv python3-pip
            ;;
        E)
            main
            ;;
        *)
            echo "Invalid choice."
            sleep 2
            __INSTALL_PYTHON
            ;;
    esac

    title

    echo "Installing pip..."
    sudo apt-get install -y -f python3-pip
    sudo pip3 install -U pip

    title
    echo "Installed Successfully!"
    sleep 2

    main
}

function __INSTALL_JAVA() {
    title
    echo "openJDK Version : "

    echo "└─ (1) jdk-21"

    echo -e

    echo "(E) Exit"

    echo -e

    read -p "Enter your choice : " choice

    echo "Installing openJDK..."
    case $choice in
        1)
            sudo apt install -y openjdk-21-jdk
            ;;
        E)
            main
            ;;
        *)
            echo "Invalid choice."
            sleep 2
            __INSTALL_JAVA
            ;;
    esac

    title
    echo "Installed Successfully!"
    sleep 2

    main
}

function __INSTALL_GCC() {
    title
    echo "Installing gcc..."
    sudo apt install gcc -y

    title
    echo "Installed Successfully!"
    sleep 2

    main
}

function __INSTALL_ZIP() {
    title
    echo "Installing zip..."
    sudo apt install zip -y

    title
    echo "Installing unzip..."
    sudo apt install unzip -y

    title
    echo "Installed Successfully!"
    sleep 2

    main
}

function __INSTALL_RCLONE(){
    title
    echo "Installing RClone..."
    sudo apt install fuse -y
    sudo apt install rclone -y

    title
    echo "Installed Successfully!"
    sleep 2

    main
}

setup
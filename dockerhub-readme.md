# Coder-SSH

[![Docker Pulls](https://img.shields.io/docker/pulls/caloutw/coder-ssh)](https://hub.docker.com/r/caloutw/coder-ssh)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/caloutw/coder-ssh/latest)](https://hub.docker.com/r/caloutw/coder-ssh)
[![Multi-Arch](https://img.shields.io/badge/multi--arch-linux%2Famd64%20%7C%20linux%2Farm64-blue)](https://hub.docker.com/r/caloutw/coder-ssh)

🚀 **Multi-architecture SSH development environment** based on Ubuntu 24.04 LTS. Perfect for remote development with VS Code and other IDEs.

## ✨ Features

- 🔧 **Multi-architecture support**: x86_64 (AMD64) and ARM64
- 🐧 **Ubuntu 24.04 LTS** base image
- 🔐 **SSH server** ready for remote connections
- 💻 **VS Code** remote development support
- 🛠️ **Pre-installed tools**: git, curl, wget, sudo
- 🔒 **Secure**: Non-root user with sudo access
- 📦 **Lightweight**: Optimized for development workflows

## 🏗️ Supported Architectures

| Architecture | Tag | Description |
|--------------|-----|-------------|
| x86_64 | `linux/amd64` | Intel/AMD processors |
| ARM64 | `linux/arm64` | Apple Silicon (M1/M2/M3), ARM servers |

## 🚀 Quick Start

### Pull and Run

```bash
# Pull the latest image
docker pull caloutw/coder-ssh:latest

# Run the container
docker run -d \
  --name coder-ssh \
  -p 2222:22 \
  caloutw/coder-ssh:latest
```

### Connect via SSH

```bash
# Connect to the container
ssh -p 2222 ubuntu@localhost

# Default credentials:
# Username: ubuntu
# Password: Abcd1234
```

## 🔧 Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `USERNAME` | `ubuntu` | SSH username |
| `PASSWORD` | `Abcd1234` | SSH password |
| `SUDO_PASSWORD` | `Abcd1234` | Sudo password |

### Custom Configuration

```bash
docker run -d \
  --name coder-ssh \
  -p 2222:22 \
  -e USERNAME=developer \
  -e PASSWORD=MySecurePassword123 \
  caloutw/coder-ssh:latest
```

## 💻 VS Code Integration

1. **Install VS Code Remote - SSH extension**
2. **Connect to your container**:
   ```
   ssh -p 2222 ubuntu@localhost
   ```
3. **Open VS Code** and use `Ctrl+Shift+P` → "Remote-SSH: Connect to Host"
4. **Enter connection details**: `ubuntu@localhost:2222`

## 🐳 Docker Compose

```yaml
version: '3.8'
services:
  coder-ssh:
    image: caloutw/coder-ssh:latest
    container_name: coder-ssh
    ports:
      - "2222:22"
    environment:
      - USERNAME=developer
      - PASSWORD=MySecurePassword123
    restart: unless-stopped
    volumes:
      - ./workspace:/home/ubuntu/workspace
```

## 🔒 Security Notes

- ⚠️ **Change default passwords** in production
- 🔐 **Use SSH keys** instead of passwords for better security
- 🌐 **Limit port exposure** to trusted networks
- 📝 **Review logs** regularly

## 📦 What's Included

- **Base OS**: Ubuntu 24.04 LTS
- **SSH Server**: OpenSSH with optimized configuration
- **Development Tools**: git, curl, wget, sudo
- **User Management**: Non-root user with sudo access
- **VS Code Support**: Ready for remote development

## 🔗 Links

- 📖 **[GitHub Repository](https://github.com/caloutw/Coder-SSH)**
- 🐛 **[Issue Tracker](https://github.com/caloutw/Coder-SSH/issues)**
- 📄 **[Documentation](https://github.com/caloutw/Coder-SSH/blob/main/README.md)**

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/caloutw/Coder-SSH/blob/main/LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

**Made with ❤️ by [caloutw](https://github.com/caloutw)**

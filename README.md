# Docker Snort3

![image](https://github.com/MikeHorn-git/docker-snort3/assets/123373126/b822ff3c-d7d5-4f7d-97a0-9e937d4fef7b)

# Warning
Beta version. In progress, see the [To-Do](https://github.com/MikeHorn-git/docker-snort3?tab=readme-ov-file#to-do) section

# Description
Unofficial [snort3](https://www.snort.org/snort3) IDS/IPS software docker image.

# Information
* From : Debian Bookworm Slim.
* Size : Around 2.3GB.
* Time : Build from source. Take multiples minutes epending on your system.
* Trivy : 0 unfixed vulnerabilities.

# Installation
## Docker Hub
```bash
sudo docker pull mikehorn/snort3:latest
```

## Build Yourself
```bash
https://github.com/MikeHorn-git/docker-snort3.git
cd docker-snort3/
```

### Docker Compose
```bash
sudo docker-compose up -d
```

### Dockerfile
```bash
sudo docker build -t "snort3" .
```

# Security
* The snort3 Docker image is scanned with [trivy](https://github.com/aquasecurity/trivy) to improve security.
* Install [docker-bench-security](https://github.com/docker/docker-bench-security) for hardening your host.

# To-Do
- [ ] Create and configure snort.conf file.
- [x] Add docker-compose.yml file.
- [x] Push image to Docker Hub.

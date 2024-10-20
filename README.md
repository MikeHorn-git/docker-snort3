# Docker Snort3

![image](https://github.com/MikeHorn-git/docker-snort3/assets/123373126/b822ff3c-d7d5-4f7d-97a0-9e937d4fef7b)

# Description
Unofficial [snort3](https://www.snort.org/snort3) IDS/IPS software docker image.

# Information
* From : Debian Bookworm Slim
* Size : 756 MB
* Time : Build from source. Take multiples minutes depending on your system
* Snort Version : 3.3.7.0
* Libdaq Version : 3.0.16
* Trivy : 0 unfixed vulnerabilities.

# Installation
## Docker Hub
```bash
docker pull mikehorn/snort3:latest
```

## Build Yourself
```bash
git clone https://github.com/MikeHorn-git/docker-snort3.git
cd docker-snort3/
docker compose build
```

# Usage
To use file from your host :
* Create a directory in your home with the name snort
* Modify the docker-compose.yml, to replace the $USER var to your username in the volumes section
* Place the files you want in host : /home/$USER/snort
* In the docker container they are available at /files

## Example 1
```bash
docker compose run --rm snort3 -i eth0
```
## Example 2
```bash
docker compose run --rm snort3 -r /files/file.pcap
```

# Security
* Lint with [hadolint](https://github.com/hadolint/hadolint)
* Scan with [trivy](https://github.com/aquasecurity/trivy)

# To-Do
- [ ] Create and configure snort.conf file.
- [x] Add docker-compose.yml file.
- [x] Push image to Docker Hub.

# Docker Snort3

![image](https://github.com/MikeHorn-git/docker-snort3/assets/123373126/d544a143-7e37-4ee1-b2ad-99fc2d4ef5af)

# Warning
Beta version. In progress, see the [To-Do]() section

# Description
Unofficial [snort3](https://www.snort.org/snort3) docker image.

# Information
* From : Debian Bookworm Slim.
* Size : Around 2.3GB.
* Time : Build from source. Take multiples minutes epending on your system.
* Trivy : 0 unfixed vulnerabilities.

# Installation
## Build Yourself
```bash
git clone https://github.com/MikeHorn-git/docker-forensic-toolbox.git
cd docker-forensic-toolbox
```

### Dockerfile
```bash
sudo docker build -t "dft" .
```

# Security
* The snort3 Docker image is scanned with [trivy](https://github.com/aquasecurity/trivy) to improve security.
* Install [docker-bench-security](https://github.com/docker/docker-bench-security) for hardening your host.

# To-Do
- [ ] Create and configure snort.conf file.
- [ ] Add Docker-compose yaml file.
- [ ] Push image to docker image.

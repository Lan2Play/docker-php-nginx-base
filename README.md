# Base image with PHP & Nginx for Eventula manager

- PHP8.2 - v4
- PHP8.1 - v3 - Unsupported
- PHP8 - v2 - Unsupported
- PHP7 - v1 - Unsupported

docker buildx is require to build multiple archs

```docker buildx build --platform linux/amd64,linux/arm/v7 --no-cache --push -t lan2play/php-nginx-base:latest .```

## Notes

To allow for ArmV7 build you must run the commands below:

```docker run --rm --privileged docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3```
```docker run --privileged linuxkit/binfmt:v0.7```
```export DOCKER_CLI_EXPERIMENTAL=enabled```
```systemctl restart systemd-binfmt```

# Base image with PHP & Nginx for Eventula manager

- PHP8.3 - v5
- PHP8.2 - v4 - Unsupported
- PHP8.1 - v3 - Unsupported
- PHP8 - v2 - Unsupported
- PHP7 - v1 - Unsupported

docker buildx is require to build multiple archs

```docker buildx build --platform linux/amd64,linux/arm/v7 --no-cache --push -t lan2play/php-nginx-base:latest .```

# Credits

This repository is initially based of the work in [th0rn0's](https://github.com/th0rn0) [docker-php-nginx-base](https://github.com/th0rn0/docker-php-nginx-base). Thanks for that!
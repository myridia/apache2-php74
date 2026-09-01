# AGENTS.md — apache2-php74

## What this is
Docker image with Debian Bookworm, Apache, and PHP 7.4, preconfigured with many PHP extensions, MySQL/PostgreSQL clients, composer, git, and supervisor for SSH + Apache.

## Stack
- Debian bookworm
- Apache2 (+ mod_php7.4, rewrite)
- PHP 7.4 (surys package)
- Supervisor (supervisord)
- Composer

## Build
```bash
./build.sh   # docker build -t apache2-php74 .
```

## Run
```bash
docker run -p 80:80 -p 22:22 -it apache2-php74
```

## Structure
- `Dockerfile` — image definition
- `supervisord.conf` — supervisor config (Apache + SSH)
- `build.sh` — build helper
- `remove_all_dockers.sh` — cleanup helper

## Conventions
- No comments in code unless asked.
- Verify: `docker build .`
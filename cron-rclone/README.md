# cron-rclone

This is a small alpine-based image that I use for cloning local backups made by -arr apps to remote services.
It contains rclone bundled in. It's meant to be used as sidecar container for k8s-based workloads

## Usage

Build image
```sh
docker build -t cron-rclone .
```

You need to provide CRON and COMMAND variables that contain crontab and
command you want to run periodically.
You can also optionally mount scripts and data directory you want to backup.

Run container
```sh
docker run -v path/to/data:/data \
    -e CRON="* * * * *" \
    -e COMMAND="rclone sync /data dest:source" \
    --name cron-rclone \
    cron-rclone
```
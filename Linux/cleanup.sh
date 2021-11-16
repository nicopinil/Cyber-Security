#!/bin/bash

rm -rf /tmp/*
rm -rf /var/tmp/*

# Clear apt cache to free up disk space.
apt clean -y

# Clear thumbnail cache for sysadmin, instructor, and student
rm -rf /home/sysadmin/.cache/thumbnails
rm -rf /home/instructor/.cache/thumbnails
rm -rf /home/student/.cache/thumbnails
rm -rf /root/.cache/thumbnails

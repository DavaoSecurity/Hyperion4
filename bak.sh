#!/bin/bash

rm /cerubbak.tar.gz

sudo tar czf /cerubbak.tar.gz \
    --exclude=/cerubbak.tar.gz \
    --exclude=/dev \
    --exclude=/mnt \
    --exclude=/proc \
    --exclude=/sys \
    --exclude=/tmp \
    --exclude=/media \
    --exclude=/lost+found \
    /

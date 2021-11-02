#! /bin/sh

pdftops $1 /tmp/input.ps
ps2pdf /tmp/input.ps $2

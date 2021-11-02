#!/bin/sh
argc=$1
git add --all
git commit -a -m $argc
git push origin master

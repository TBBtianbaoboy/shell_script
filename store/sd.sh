#!/bin/sh
site=$1
git init
git remote add origin git@github.com:TBBtianbaoboy/$site.git
git add --all
git commit -a -m 'all'
git push -f origin master

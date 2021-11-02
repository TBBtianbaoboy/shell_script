#!/bin/sh
###用于同步git与svn
go mod vendor
git add --all
git commit -a -m "dev:web:ksp"
git remote add origin ssh://git@192.168.30.140:2222/ksp/ksp_web.git
git push -u origin master -f

#数据恢复
git remote remove origin
git reset --mixed HEAD~1
rm -fr vendor 
git restore go.mod

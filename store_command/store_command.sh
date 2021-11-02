command=$@
current_path=`pwd`
file_name=$current_path/README.md

touch $file_name 

echo $command >> $file_name

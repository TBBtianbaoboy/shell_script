#!/bin/bash
file_array=()
function ergodic(){
  for file in `ls $1`
  do
    if [ -d $1"/"$file ]
    then
      ergodic $1"/"$file
    else
      local path=$1"/"$file 
      file_array+=($path)
    fi
  done
}

# --------------------------- main
function get_file_path(){
    IFS=$'\n'
    INIT_PATH=".";
    ergodic $INIT_PATH
}

function encode_file(){
    for file in ${file_array[@]}
    do
        if [[ ${file##*.} == "h" || ${file##*.} == "cpp" ]];then
            echo $file
            sed -i 's#VACL_FUNC_CHECK_RET_ERR_NO_QUIT#VACL_FUNC_CHECK#g' $file
        fi
    done
}

main() {
    get_file_path
    encode_file
}
main $@

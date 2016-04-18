#!/bin/bash
 
trash_dir=${HOME}/.Trash/$(date +%Y%m%d%H%M%S)
 
function move_item(){
  mkdir -p ${trash_dir}${full_dir}
  echo -n "Moving ${item} to ${trash_dir}${full_path}..."
  mv ${item} ${trash_dir}${full_path}
  if [[ $? -eq 0 ]]; then
    echo " Done"
  fi
}
 
for item in $@; do
  if $(echo ${item} |grep -vq '^-'); then
    if $(echo ${item} |grep -q '^/'); then
      full_path=${item}
    else
      full_path=$(pwd)/${item}
    fi
    full_dir=$(dirname ${full_path})
    if $(echo $@ |grep -Ewq '\-rf|\-f|\-fr'); then
      move_item
    else
      echo -n "Move ${item} to ${trash_dir}${full_path}? [y/n] "
      read yorn
      if $(echo ${yorn} |grep -Ewq 'y|Y|yes|YES'); then
        move_item
      fi
    fi
  fi
done

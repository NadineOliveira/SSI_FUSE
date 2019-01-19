#!/bin/bash

function testLibcurl(){
  ldconfig -p | grep libcurl
}

function testFuse3(){
	ldconfig -p | grep fuse3
}

curlVal="$(testLibcurl)"
fuseVal="$(testFuse3)"

curlExists=false
fuseExists=false

if [ ! -z "$curlVal" ]
then
  curlExists=true
fi

if [ ! -z "$fuseVal" ]
then
  fuseExists=true
fi



if($curlExists)
then 
  echo "library curl detected in your computer"
  if($fuseExists)
  then 
    echo "library fuse3 detected in your computer"
    echo "starting compilation"
    gcc -Wall teste.c `pkg-config fuse3 --cflags --libs` -o teste
    gcc client.c -o client -D_FILE_OFFSET_BITS=64
  else
    echo "fuse3 not detected in your computer"
    echo "unfortunatly we have no idea how to fix this, and we can't run the program without it"
    echo "sorry about that"
  fi
else
  echo "curl not detected in your computer, install it with 'sudo apt-get install libcurl4-openssl-dev'(if your ubuntu, if search for an alternative)"
fi

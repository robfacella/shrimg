#!/usr/bin/env bash
home=$(pwd)
DepFile=${home}"/Dependencies"
cd $DepFile
for Dep in $(ls)
do
  echo "Running "$Dep
  bash $Dep
done

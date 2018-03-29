#!/usr/bin/env bash
if [[ $EUID -ne 0 ]]; then
  echo "ERROR: Must be root to install dependencies."
  exit 1
fi
home=$(pwd)
DepFile=${home}"/Dependencies"
cd $DepFile
for Dep in $(ls)
do
  echo "Running "$Dep
  bash $Dep
done

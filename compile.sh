#!/bin/sh

NSC=nsc
NSFLAGS='-q -v1.69 -i ../include/:../ALFA-Base-Resources/alfa2_acr.hak/'

echo Cleaning

rm -rf *.NCS
rm -rf *.ncs
rm -fr *.ndb
rm -fr *.NDB

for f in *.NSS
do
  echo Renaming $f
  mv $f `echo $f|awk '{$1=tolower($1);print}'`
done

for f in *.nss
do
  echo Compiling $f
  $NSC $NSFLAGS -c $f
done

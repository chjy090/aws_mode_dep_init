#!/bin/bash
cat data4 | while read a; do 
  data=`date +%s`
  eval time $a 
  echo $a >> data6
done

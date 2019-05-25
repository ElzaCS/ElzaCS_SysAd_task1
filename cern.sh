#!/bin/bash

useradd MasterH
useradd Heisenberg
useradd Hertz
useradd Holland

groupmod -n scientists Heisenberg
usermod -G scientists Hertz
usermod -G scientists Holland

setfacl -m d:Heisenberg:rwx /home/Heisenberg
setfacl -m d:Hertz:rwx /home/Hertz
setfacl -m d:Holland:rwx /home/Holland

setfacl -m d:MasterH:rwx /home/Heisenberg
setfacl -m d:MasterH:rwx /home/Hertz
setfacl -m d:MasterH:rwx /home/Holland

for ((i=1;i<21;i++))
 do
   useradd Heisenberg_name$i
   useradd Hertz_name$i
   useradd Holland_name$i
   
   setfacl -d -m g:scientists:rwx /home/Heisenberg_name$i
   setfacl -d -m g:scientists:rwx /home/Hertz_name$i
   setfacl -d -m g:scientists:rwx /home/Holland_name$i
  done
  
 for ((i=1;i<6;i++))
  do
   mkdir /home/Heisenberg/task$i
   mkdir /home/Hertz/task$i
   mkdir /home/Holland/task$i
   
   for ((j=1;j<21;j++))
   do
    mkdir /home/Heisenberg_name$j/task$i
    mkdir /home/Hertz_name$j/task$i
    mkdir /home/Holland_name$j/task$i
   done
   
  done
  
 for ((i=1;i<6;i++))
 do 
  for ((j=1;j<51;j++))
  do
   </dev/urandom tr -dc "[:graph:]" | head -c128 > /home/Heisenberg/task$i/Heisenberg_task$j
   </dev/urandom tr -dc "[:graph:]" | head -c128 > /home/Hertz/task$i/Hertz_task$j
   </dev/urandom tr -dc "[:graph:]" | head -c128 > /home/Holland/task$i/Holland_task$j
  done
 
 done
 
 ##To be executed in crontab at 0 0 * * *
 for ((i=1;i<21;++))
  do 
   for ((j=1;j<6;j++))
    do
     ls /home/Heisenberg/task$j | shuf -n 5 | xargs -i mv {} /home/Heisenberg_name$i/task$j
     ls /home/Hertz/task$j | shuf -n 5 | xargs -i mv {} /home/Hertz_name$i/task$j
     ls /home/Holland/task$j | shuf -n 5 | xargs -i mv {} /home/Holland_name$i/task$j
    done
    
   done



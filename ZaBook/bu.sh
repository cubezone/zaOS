#! /bin/sh

if [ $1 -eq 101 ]; then
 vid=$1
 vename="English NAME"
 vcname="中文"
fi 

if [ $1 -eq  102 ]; then
 vid=$1
 vename="ENAME"
 vcname="CNAME"
fi

printf "s/VERID/" > s.dat
printf $vid >> s.dat
printf "/g\n" >> s.dat

printf "s/ENAME/" >> s.dat
printf $vename >> s.dat
printf "/g\n" >> s.dat

printf "s/CNAME/" >> s.dat
printf $vcname >> s.dat
printf "/g" >> s.dat

cat conf.tmp  | sed -f s.dat > bar.xml

barfile=zaBook${1}_1.100.0.242.bar

blackberry-nativepackager -package $barfile  bar.xml

blackberry-signer  -cskpass  popopuoiy    -keystore author.p12  -storepass popopuoiy   $barfile RDK

blackberry-signer  -keystore author.p12 -storepass  popopuoiy  $barfile  author


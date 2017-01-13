#!/bin/bash
# author: SM
# created: 12.01.2017

#MinID: https://kataster.skgeodesy.sk/eskn/rest/services/VRM/identify/MapServer/8/query?outStatistics=[{%22statisticType%22:%22min%22,%22onStatisticField%22:%22id%22,%22outStatisticFieldName%22:%22MinID%22}]&f=json
#MaxID: https://kataster.skgeodesy.sk/eskn/rest/services/VRM/identify/MapServer/8/query?outStatistics=[{%22statisticType%22:%22max%22,%22onStatisticField%22:%22id%22,%22outStatisticFieldName%22:%22MaxID%22}]&f=json

RestLayer="https://kataster.skgeodesy.sk/eskn/rest/services/VRM/identify/MapServer/8"
OutFields="ID,CADASTRAL_UNIT_CODE,CADASTRAL_UNIT_NAME"
MinID=1
MaxID=3559
count=${MinID}
epsg=4326
OutputLayer="katastre.shp"

echo `date`
while [ ${count} -le ${MaxID} ]
do
    let "kazdy_desiaty = ${count} % 10"
    if [[ ${kazdy_desiaty} -eq 0 ]];
        then printf "${count} ";
    fi
    ogr2ogr --config SHAPE_ENCODING UTF-8 -f "ESRI Shapefile" ${OutputLayer} -append "${RestLayer}/query?where=&objectids=${count}&outfields=${OutFields}&outSR=${epsg}&returnGeometry=true&returnCountOnly=false&f=json" OGRGeoJSON
    (( count++ ))
done
echo `date`


/***
#progressmeter:
#!/bin/bash
count=1
MaxID=20

#let "1Perc = "
jedno_percento=$( echo "${MaxID} / 100" |bc -l )
#jedno_percento=$(bc -l <<<"${MaxID} / 100")
#echo "${jedno_percento} * 5" |bc -l

while [ ${count} -le ${MaxID} ]
do
vysledok=$( echo "${count} / ${jedno_percento}" |bc -l )
printf "%.0f" `echo "${vysledok}" |tr -s '.' ','`
#    let "kazdy_desiaty = ${count} % 2"
#    if [[ ${kazdy_desiaty} -eq 0 ]];
#        then printf "${count} ";
#    fi
    (( count++ ))
sleep 1
done
***/

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
while [ $count -le ${MaxID} ]
do
    let "kazdy_desiaty = $count % 10"
    if [[ $kazdy_desiaty -eq 0 ]];
        then echo "$count";
    fi
    ogr2ogr --config SHAPE_ENCODING UTF-8 -f "ESRI Shapefile" ${OutputLayer} -append "${RestLayer}/query?where=&objectids=${count}&outfields=${OutFields}&outSR=${epsg}&returnGeometry=true&returnCountOnly=false&f=json" OGRGeoJSON
    (( count++ ))
done
echo `date`

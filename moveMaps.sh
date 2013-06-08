#!/bin/bash
# maps.sh

originMetal="maps/tieldmaps/solo/metalman/"
criteriaMetal="*.lua"
destMetal="maps/exported/solo/metalman/"
clientMetal="lua/client/maps/solo/metalman/"

for i in $( ls *$originMetal$criteriaMetal* ); 
do
    src=$i
    filename=$(echo $i | sed -e "s%$originMetal%%")
    mv $src $destMetal$filename
done

for i in $( ls *$destMetal$criteriaMetal* ); 
do
    src=$i
    filename=$(echo $i | sed -e "s%$destMetal%%")
    number=$(echo $filename | sed -e "s%.lua%%")
    cp $destMetal$filename "$clientMetal$number-fieldmap/map.lua"
done

echo "Solo MetalMan Done"

originMagnet="maps/tieldmaps/solo/metalman/"
criteriaMagnet="*.lua"
destMagnet="maps/exported/solo/metalman/"
clientMagnet="lua/client/maps/solo/metalman/"

for i in $( ls *$originMagnet$criteriaMagnet* ); 
do
    src=$i
    filename=$(echo $i | sed -e "s%$originMagnet%%")
    mv $src $destMagnet$filename
done

for i in $( ls *$destMagnet$criteriaMagnet* ); 
do
    src=$i
    filename=$(echo $i | sed -e "s%$destMagnet%%")
    number=$(echo $filename | sed -e "s%.lua%%")
    cp $destMagnet$filename "$clientMagnet$number-fieldmap/map.lua"
done

echo "Solo The Magnet Done"

originMulti="maps/tieldmaps/multi/"
criteriaMulti="*.lua"
destMulti="maps/exported/multi/"
clientMulti="lua/client/maps/multi/"
serverMulti="lua/server/maps/"

for i in $( ls *$originMulti$criteriaMulti* ); 
do
    src=$i
    filename=$(echo $i | sed -e "s%$originMulti%%")
    mv $src $destMulti$filename
done

for i in $( ls *$destMulti$criteriaMulti* ); 
do
    src=$i
    filename=$(echo $i | sed -e "s%$destMulti%%")
    number=$(echo $filename | sed -e "s%.lua%%")
    cp $destMulti$filename "$clientMulti$number-fieldmap/map.lua"
    cp $destMulti$filename "$serverMulti$filename"
done

echo "Multi Done"

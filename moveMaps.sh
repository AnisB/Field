#!/bin/bash
# maps.sh

worlds="maps/tieldmaps"

for j in $( ls *$worlds* ); 
do
    world="$worlds/$j"


    originMetal="solo/metalman/"
    criteriaMetal="*.lua"
    destMetal="maps/exported/solo/metalman/"
    clientMetal="lua/client/maps/solo/metalman/"

    for i in $( ls *$world/$originMetal$criteriaMetal* ); 
    do
        src=$i
        filename=$(echo $i | sed -e "s%$world/$originMetal%%")
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

    originMagnet="solo/themagnet/"
    criteriaMagnet="*.lua"
    destMagnet="maps/exported/solo/themagnet/"
    clientMagnet="lua/client/maps/solo/themagnet/"

    for i in $( ls *$world/$originMagnet$criteriaMagnet* ); 
    do
        src=$i
        filename=$(echo $i | sed -e "s%$world/$originMagnet%%")
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

    originMulti="multi/"
    criteriaMulti="*.lua"
    destMulti="maps/exported/multi/"
    clientMulti="lua/client/maps/multi/"
    serverMulti="lua/server/maps/"

    for i in $( ls *$world/$originMulti$criteriaMulti* ); 
    do
        src=$i
        filename=$(echo $i | sed -e "s%$world/$originMulti%%")
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

    echo "$world Done"

done

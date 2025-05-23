#!/bin/bash

blender=$HOME/usr/bin/blender
MOUTH_ARRAY=('a' 'i' 'u' 'e' 'o' 'n')
create=$HOME/B4卒研/create_face_model
frame=$HOME/B4卒研/frame-interpolation
render=$HOME/B4卒研/render_face_model
times=2

frames=$((2**times-1))
roop1=0
roop2=0

cd $create
player=$(python3 input_player_name.py)
echo "your name is \"$player\"."

cd $create
python3 main.py -c -n $player

for mouth_before in ${MOUTH_ARRAY[@]}
do
    for mouth_after in ${MOUTH_ARRAY[@]}
    do
        if [ $roop1 -lt $roop2 ]; then
            mouth="$mouth_before-$mouth_after"
            echo "create $mouth. Interpolate $frames frames."
            
            cd $frame
            python3 -m eval.interpolator_cli \
            --model_path pretrained_models/film_net/Style/saved_model \
            --times_to_interpolate $times \
            --mouth_shape $mouth \
            --output_original \
            --use_cut \
            --player_name $player \
            --pattern "$create/mqodata/model/$player"

            #cd $render
            #mouth="$mouth_before-$mouth_after"
            #echo "render $mouth."
            #blender -b -P main.py -- -m $mouth -c -n $player -f $frames
        fi
        let roop2=$roop2+1
    done
    let roop1=$roop1+1
    roop2=0
done
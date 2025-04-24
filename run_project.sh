#!/bin/bash

blender=$HOME/usr/bin/blender
create=$HOME/B4卒研/create_face_model
frame=$HOME/B4卒研/frame-interpolation
render=$HOME/B4卒研/render_face_model
times=2

frames=$((2**times-1))

cd $create
player=$(python3 input_player_name.py)
echo "your name is \"$player\"."

python3 main.py -r -c -f $frames -n $player
#python3 main.py -r -c -f $frames -n $player -i "input.png"
#!/usr/bin/env bash
. install/local_setup.bash

ros2 launch ros2_blender blender.launch.py \
  addon_paths:=src/omcp_blender/addons/omcp_blender \
  addons:=omcp_blender
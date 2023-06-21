#!/usr/bin/env bash
colcon build --symlink-install --continue-on-error --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
clion build/compile_commands.json

#!/usr/bin/env bash

colcon build \
  --symlink-install \
  --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  --event-handlers desktop_notification-
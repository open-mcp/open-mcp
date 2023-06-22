#!/usr/bin/env bash
. install/local_setup.bash

colcon test \
  --event-handlers console_direct+ \
  --event-handlers desktop_notification+

colcon test-result --verbose
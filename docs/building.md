## Setup your development enivornment

Create and enter your containerized workspace:
```bash
distrobox create --image docker.io/ros:jazzy --name open-mcp
distrobox enter open-mcp
```

Import repositories and install dependencies:
```bash
# first cd back into your workspace :)
mkdir src
vcs import --recursive --skip-existing --input open-mcp.repos src/
rosdep update && rosdep install --from-paths src
```

## Build and test open-mcp

In order to build the workspace, run:
```bash
colcon build \
  --symlink-install \
  --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  --event-handlers desktop_notification- \
  --continue-on-error
```

Source the ROS environment:
```bash
bash --init-file /opt/ros/jazzy/setup.bash
source install/local_setup.bash
```

In order to run the tests, run:
```bash
colcon test \
  --event-handlers console_direct+ \
  --event-handlers desktop_notification+ ; \
  colcon test-result --verbose
```

## IDE support

### CLion

After compiling the workspace using `CMAKE_EXPORT_COMPILE_COMMANDS=ON` a _build/compile_commands.json_ file should exist, which you can open as a project using CLion.

You can add `--continue-on-error` flag when building with colcon, if your build fails, but you still want to open your project in CLion.

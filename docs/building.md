## Development enivornment
You can develop open-mcp using a dedicated system or using containers.

Since container images can be relatively big building them without layers and history might be a good option in case you're short on disk space. To do this you can build the container image by running:
```bash
podman build --layers=false --omit-history=true .
```

## Build and test
In order to build the workspace, run:
```bash
colcon build \
  --symlink-install \
  --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  --event-handlers desktop_notification-
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
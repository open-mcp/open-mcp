ARG ROS_DISTRO="jazzy"

FROM docker.io/ros:${ROS_DISTRO}

# # See https://github.com/opencontainers/runc/issues/2517
# RUN echo 'APT::Sandbox::User "root";' > /etc/apt/apt.conf.d/sandbox-disable

ENV ROS_OVERLAY /opt/ros/open-mcp

WORKDIR $ROS_OVERLAY

COPY open-mcp.repos open-mcp.repos
RUN mkdir src && \
    vcs import --input open-mcp.repos src

RUN apt-get update && \
    rosdep install -iy --from-paths src && \
    rm -rf /var/lib/apt/lists/

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon build --symlink-install --continue-on-error

# RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
#     colcon test ; \
#     colcon test-result --verbose

# RUN sed --in-place --expression \
#     '$isource "${ROS_OVERLAY}/install/setup.bash"' \
#     /ros_entrypoint.sh

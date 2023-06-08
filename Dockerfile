ARG ROS_DISTRO="humble"

FROM docker.io/ros:${ROS_DISTRO}

# See https://github.com/opencontainers/runc/issues/2517
RUN echo 'APT::Sandbox::User "root";' > /etc/apt/apt.conf.d/sandbox-disable

ENV ROS_OVERLAY /opt/ros/omcp

WORKDIR $ROS_OVERLAY

# Workaround for https://github.com/emanuelbuholzer/omcp_blender/issues/1
RUN apt-get update &&  \
    apt-get install -y python3-pip &&  \
    python3 -m pip install pytest-blender && \
    rm -rf /var/lib/apt/lists/

COPY omcp.repos omcp.repos
RUN mkdir src && \
    vcs import --input omcp.repos src

RUN apt-get update && \
    rosdep install -iy --from-paths src && \
    rm -rf /var/lib/apt/lists/

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon build --continue-on-error

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon test ; \
    colcon test-result --verbose

RUN sed --in-place --expression \
    '$isource "${ROS_OVERLAY}/install/setup.bash"' \
    /ros_entrypoint.sh

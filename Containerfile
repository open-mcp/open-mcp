ARG ROS_DISTRO="humble"

FROM docker.io/ros:${ROS_DISTRO}

ENV ROS_OVERLAY /opt/ros/omcp

WORKDIR $ROS_OVERLAY

COPY omcp.repos omcp.repos
RUN mkdir src && \
    vcs import --input omcp.repos src

RUN apt-get update && \
    rosdep install -iy --from-paths src && \
    rm -rf /var/lib/apt/lists/

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon build

RUN sed --in-place --expression \
    '$isource "${ROS_OVERLAY}/install/setup.bash"' \
    /ros_entrypoint.sh
# Installing omcp

## System requirements

In order to run omcp, you will need a Ubuntu 22.04.02 LTS (Jammy Jellyfish) with ROS 2 Humble Hawksbill and its development tools installed.
It is generally recommended that you have at least 16GB of RAM and an something equivalent to a more or less recent Intel i7 or better.

### Installing Ubuntu Jammy

In order to install Ubuntu 22.04.02 LTS (Jammy Jellyfish) it is recommended to use the latest Ubuntu Desktop image.
For that, [download the latest desktop image](https://releases.ubuntu.com/jammy/), flash it to a USB stick and boot from it.

Follow the instructions on your screen to install Ubuntu. 
It is generally recommended to do a minimal installation, to download updates while installing and to install third-party software for graphics, Wi-Fi hardware and additional media formats.

### Installing ROS 2 Humble

In order to install ROS 2 Humble and its development tools it is generally recommended to use the ROS 2 Debian packages.

Ensure that the Ubuntu Universe repository is enabled:
```bash
sudo apt install software-properties-common
sudo add-apt-repository universe
```

Add the ROS 2 repository:
```bash
sudo apt update && sudo apt install -y curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```

Update your repository caches and update your system:
```bash
sudo apt update 
sudo apt upgrade
```

Install ROS 2 Humble Hawksbill Desktop and development tools.
```bash 
sudo apt install -y ros-humble-desktop ros-dev-tools
echo -e "\n# ROS 2 Humble Hawksbill\nsource /opt/ros/humble/setup.bash" >> ~/.bashrc && source /opt/ros/humble/setup.bash
```

Verify that you've successfully installed ROS 2 Humble Hawksbill:
```bash
ros2 doctor --report
```

## Installation

In order to install omcp its recommended to build omcp and it's packages from source.

Create a new workspace for omcp:
```bash
mkdir -p ~/omcp/src
cd ~/omcp
```

Import the sources for omcp's packages:
```bash
vcs import --input https://raw.githubusercontent.com/emanuelbuholzer/omcp/main/omcp.repos src
```

Initialize rosdep and update its caches:
```bash
sudo rosdep init > /dev/null
rosdep update
```

Install omcp's dependencies and build omcp:
```bash
rosdep install -iy --from-paths src
colcon build --symlink-install
```

Install omcp for the current user:
```bash
echo -e "\n# omcp\nsource ~/omcp/install/setup.bash" >> ~/.bashrc && source ~/omcp/install/setup.bash
```
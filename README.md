
# Prerequisites
- Ubuntu 22.04 jammy
- ROS 2 Humble
- Gazebo 11
- mediapipe
- opencv-python
- java processing (optional)
  
# run the following 
`
  sudo apt update
  sudo apt install ros-humble-gazebo-ros-pkgs ros-humble-teleop-twist-keyboard `

# Set up workspace
`
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws `

# copy hri_mobile_robot_description to the workspace you just created
`
cp -r /hri_mobile_robot_description ~/ros2_ws/src/ `

# build the workspace
`
cd ~/ros2_ws
colcon build `

# source the workspace
`
source ~/ros2_ws/install/setup.bash `


# to run

GESTURE_ros_sim for using gesture control
TELEOP_ros_sim for teleop control

sometimes you may need to unplug and replug controller back in to make ubuntu see it depending on what gamepad you're using

may also need to do 
`
chmod 777 GESTURE_ros_sim 
chmod 777 TELEOP_ros_sim
`

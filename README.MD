# NVIDIA-Docker with ROS

* Nvidia-Docker2 with ROS
* GUI support


# Use Docker with GUI

First, disable access control to make sure clients can connect from any host.

```bash
sudo apt-get install x11-xserver-utils
xhost +
```

Then run our `start.sh` will start a simple test container. You could modify it by yourself for you application.

```bash
bash ./start.sh

#In container
roscore > /dev/null & rosrun rviz rviz
```

# Reference

* [Using Hardware Acceleration with Docker](http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration#nvidia-docker2)

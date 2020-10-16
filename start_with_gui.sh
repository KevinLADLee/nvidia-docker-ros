#!/bin/bash 

ros_version=( 
  "desktop"
  "desktop-full"
) 

select var in ${ros_version[@]} 
do
  if [ $var = "desktop" ]; then
    ROS_VERSION="desktop"
    break
  else 
    ROS_VERSION="desktop-full"
  fi
done

xhost +

XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

docker run -it \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e XAUTHORITY=$XAUTH \
    -v $XAUTH:$XAUTH \
    --runtime=nvidia \
    kevinlad/nvidia-docker-ros:10.2-cudnn7-melodic-$ROS_VERSION \
    bash
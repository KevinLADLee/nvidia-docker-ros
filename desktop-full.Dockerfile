FROM kevinlad/nvidia-docker-ros:10.2-cudnn7-melodic-desktop

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-desktop-full=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*


FROM kevinlad/nvidia-docker-ros:10.2-cudnn7-melodic-core

ENV TZ='Asia/Shanghai'

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -q -y \
    build-essential \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
# RUN rosdep init && \
#     rosdep update --rosdistro melodic

# install ros-melodic-ros-base packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    ros-melodic-ros-base=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

# install ros-melodic-robot packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    ros-melodic-robot=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

# install ros-melodic-perception packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-perception=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

# install ros-melodic-desktop packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-desktop=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*    

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
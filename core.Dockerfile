FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

ENV TZ='Asia/Shanghai'

RUN sed -i 's/^/#&/g' /etc/apt/sources.list.d/cuda.list && \
    sed -i 's/^/#&/g' /etc/apt/sources.list.d/nvidia-ml.list

# setup timezone
RUN echo ${TZ} > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apt-get update && apt-get install -q -y tzdata && rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# install ros packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    ros-melodic-ros-core=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

RUN echo "source /opt/ros/melodic/setup.bash" >> /root/.bashrc

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
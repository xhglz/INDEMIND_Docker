#!/bin/sh

xhost +local:root;
DOCKER_IMSEESDK="/path/IMSEE-SDK/IMSEE-SDK"
sudo docker run -it --privileged=true --net=host \
    -e DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $DOCKER_IMSEESDK:/root/IMSEE-SDK \
    -v /dev:/dev \
    xhglz/indemind:v1 /bin/bash -c "cd /root/IMSEE-SDK; /bin/bash"
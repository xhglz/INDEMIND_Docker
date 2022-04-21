# Docker
## command
查看所有容器
```bash
docker ps -a
```
停止所有容器
```bash
docker stop $(docker ps -a -q)
```
删除所有容器
```bash
docker rm $(docker ps -aq)
```
删除所有none镜像
```bash
docker image rm -f $(docker image ls -f 'dangling=true' -q)
```
查看所有镜像
```bash
docker images list
```
查找镜像
```bash
docker search <IMAGE_ID/NAME>
```
下载镜像
```bash
docker pull <IMAGE_ID>
```
上传镜像
```bash
docker push <IMAGE_ID>
```
## 安装
在终端输入一下指令（二选一，视情况而定）。
```bash
docker build -t xhglz/indemind:v1 -f Dockerfile .
docker build -t xhglz/indemind:v1 -f Copy.Dockerfile .
```
## 编译 && 运行
根据实际情况修改 **run_indemind.sh** 中的路径，执行
```bash
sudo chmod +x run_indemind.sh
./run_indemind.sh
```
进入 Docker 后编译 IMSEE-SDK
```bash
make all
```
连接摄像头，查看画面
```bash
./demo/output/bin/get_image
```
查看 IMU 信息
```bash
$ ./demo/output/bin/get_imu
```
查看设备信息
```bash
./demo/output/bin/get_device_info
--------------------------------------
Module info: 
id: M1@
       ��H
designer: indemind
fireware_version: 1.0
hardware_version: 1.0
lens: M1@
         ��H
imu: 26602
viewing_angle: hdeg, vdeg
_baseline: 0.122567@�B
Left param: 
_width: 640, height: 400
_focal_length[0]: 242.643
_principal_point[0]: 328.887
_focal_length[1]: 242.523
_principal_point[1]: 203.619
_focal_length: { 242.643 242.523 } 
_principal_point: { 328.887 203.619 } 
_TSC: { -0.999774 -0.0212465 0.000999588 0.06 0.0212342 -0.999713 -0.0110812 0 0.00123474 -0.0110575 0.999938 -0.00164 0 0 0 1 } 
_R: { 0.99568 0.0284676 0.0883842 -0.0277128 0.999568 -0.00975557 -0.0886238 0.00726404 0.996039 } 
_P: { 258.174 0 285.156 0 0 258.174 204.724 0 0 0 1 0 } 
_K: { 242.643 0 328.887 0 242.523 203.619 0 0 1 } 
_D: { 0.604765 0.124705 -0.493269 0.204185 } 
Right param: 
_width: 640, height: 400
_focal_length[0]: 241.922
_principal_point[0]: 326.277
_focal_length[1]: 241.895
_principal_point[1]: 204.376
_focal_length: { 241.922 241.895 } 
_principal_point: { 326.277 204.376 } 
_TSC: { -0.999866 -0.0162244 -0.00217327 -0.0620733 0.0162795 -0.999466 -0.0283402 -0.00101687 -0.00171231 -0.0283718 0.999596 0.00930443 0 0 0 1 } 
_R: { 0.995549 0.0219177 0.0916569 -0.0226986 0.999714 0.00748595 -0.0914667 -0.00953311 0.995763 } 
_P: { 258.174 0 285.156 -31.6436 0 258.174 204.724 0 0 0 1 0 } 
_K: { 241.922 0 326.277 0 241.895 204.376 0 0 1 } 
_D: { 0.556904 0.255652 -0.628653 0.260327 } 
Imu param: 
_a_max: 176
_g_max: 30
_sigma_g_c: 0.12
_sigma_a_c: 0.009
_sigma_bg: 0.1
_sigma_ba: 0.001
_sigma_gw_c: 4e-05
_sigma_aw_c: 4e-05
_tau: 3600
_g: 9.802
_a0: { 0 0 0 0 } 
_T_BS: { 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 } 
_Acc: { -0.00075117 0.998817 0.00376631 0.00530777 -0.0143338 -0.00470468 0.998257 -0.0183108 0.00756131 -0.00387801 0.0176159 0.996797 } 
_Gyr: { -0.880678 1.00007 0.00457584 0.00760786 0.388882 -0.00533392 0.999803 -0.0178596 0.0538619 -0.000528772 0.0182149 1.0019 } 
Driver Close
Driver unload
```
## ROS
查看是否安装成功
```bash
roslaunch imsee_ros_wrapper display.launch
```
启动 ROS 节点，向外发布
```bash
roslaunch imsee_ros_wrapper display.launch
```
在本机上新开终端，查看节点
```bash
rostopic list

--------------------------------------
/imsee/camera_info
/imsee/image/camera_info
/imsee/image/left
/imsee/image/right
/imsee/imu
```
查看相机信息
```bash
rostopic echo /imsee/camera_info

--------------------------------------
header: 
  seq: 47
  stamp: 
    secs: 1650516735
    nsecs: 283150196
  frame_id: ''
height: 400
width: 640
distortion_model: "fisheye"
D: [0.6047646818959819, 0.12470452594379561, -0.49326923232749875, 0.20418547497402847]
K: [242.64345751389354, 0.0, 328.88728008868895, 0.0, 242.52343786305573, 203.6188620485455, 0.0, 0.0, 1.0]
R: [0.9956795799506525, 0.02846763933080449, 0.08838420435928329, -0.027712843408826078, 0.999568320424432, -0.009755568362618124, -0.0886237687050726, 0.007264042594248989, 0.9960386846431711]
P: [258.17394049096714, 0.0, 285.15602792204265, 0.0, 0.0, 258.17394049096714, 204.7239217702375, 0.0, 0.0, 0.0, 1.0, 0.0]
binning_x: 0
binning_y: 0
roi: 
  x_offset: 0
  y_offset: 0
  height: 0
  width: 0
  do_rectify: False
```
查看图像频率
```bash
rostopic hz /imsee/image/left

--------------------------------------
subscribed to [/imsee/image/left]
average rate: 50.123
	min: 0.020s max: 0.020s std dev: 0.00009s window: 50
average rate: 50.122
	min: 0.020s max: 0.020s std dev: 0.00008s window: 100
```
查看 IMU 频率
```bash
rostopic hz /imsee/imu

--------------------------------------
subscribed to [/imsee/imu]
average rate: 995.942
	min: 0.001s max: 0.002s std dev: 0.00009s window: 990
average rate: 996.017
	min: 0.001s max: 0.002s std dev: 0.00009s window: 1987
```
设置图像和 IMU 分别输出 20Hz 和 200Hz 
```
rosrun topic_tools throttle messages /imsee/image/left 20.0 /image/left
rosrun topic_tools throttle messages /imsee/image/right 20.0 /image/right
rosrun topic_tools throttle messages /imsee/imu 200.0 /imu
```


---

# IMSEE-SDK

## 概述

IMSEE-SDK是indemind双目惯性模组的软件开发工具包。模组采用“双目摄像头+IMU”多传感器融合架构与微秒级时间同步机制，为视觉SLAM研究提供精准稳定数据源。模组运用摄像头+IMU多传感器融合架构，使摄像头与IMU传感器优势互补，实现位姿精度更高、环境适应性更强、动态性能更稳定、成本更低的双目立体视觉硬件方案 。

以下平台已经经过测试:

* Windows 10
* Ubuntu 16.04 / 14.04
* Jetson TX2
* RK3399 / 3328

详细信息请参照以下文档

## 文档

* [API Doc](https://github.com/indemind/IMSEE-SDK/releases): API reference, some guides and data spec.
  * zh-Hans: [![](https://img.shields.io/badge/Online-HTML-blue.svg?style=flat)](https://imsee-sdk-docs.readthedocs.io/en/latest/)



## License

This project is licensed under the [Apache License, Version 2.0](LICENSE). Copyright 2020 Indemind Co., Ltd.


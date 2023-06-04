# Use an official Python runtime as the base image

FROM python:3.9-slim

# Set the working directory
WORKDIR /app
COPY . /app


RUN apt update || true \
       && apt install -y software-properties-common \
       && add-apt-repository ppa:deadsnakes/ppa \
       && apt install -y unzip git vim build-essential \
       zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
       libssl-dev libreadline-dev libffi-dev wget build-essential \
       cmake git libjpeg-dev libtiff5-dev libpng-dev libavcodec-dev \
       libavformat-dev libswscale-dev libxvidcore-dev libx264-dev libxine2-dev \
       libv4l-dev v4l-utils libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
       libgtk2.0-dev mesa-utils libgl1-mesa-dri libgtkgl2.0-dev libgtkglext1-dev \
       libatlas-base-dev gfortran libeigen3-dev python3-dev python3-numpy 

RUN python3.9 -m pip install --upgrade pip && python3.9 -m pip install -r requirements.txt
RUN CC="cc -mavx2" pip install -U --force-reinstall pillow-simd
WORKDIR /app
RUN mkdir saves && cd saves && wget https://github.com/hkchengrex/XMem/releases/download/v1.0/XMem-s012.pth

CMD sh -c 'python eval.py  --d17_path /DAVIS/2017 --split test --model ./saves/XMem-s012.pth --output ./output'

# docker run -it --rm -v C:\Users\ge79pih\tmo_data\rdevos-dataset:/DAVIS/2017/test-dev/ -v C:\Users\ge79pih\tmo_data\rde-output:/app/output --gpus all --shm-size=2gb xmem bash
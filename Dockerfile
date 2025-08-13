FROM nvidia/cuda:12.0.0-cudnn8-devel-ubuntu22.04
ENV LANG C.UTF-8
ENV TZ="Asia/Tokyo"
WORKDIR /root/
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
# ==================================================================
# tools
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        apt-utils \
        ca-certificates \
        software-properties-common \
        wget \
        git \
        git-lfs \
        vim \
        nano \
        libssl-dev \
        curl \
        unzip \
        unrar \
        cmake \
        libglu1 libxi6 libgconf-2-4 libsdl1.2-dev \
        primus

# ==================================================================
# python
# ------------------------------------------------------------------

RUN apt-get update && \
    apt update -y && \
    apt upgrade -y && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3.10 \
        python3.10-dev \
        python3.10-distutils\
        && \
    wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/pip/get-pip.py && \
    python3.10 ~/get-pip.py && \
    ln -s /usr/bin/python3.10 /usr/local/bin/python


RUN python3.10 -m pip install --upgrade pip && \
    pip install torch==2.2.2 torchvision==0.17.2 torchaudio==2.2.2 --index-url https://download.pytorch.org/whl/cu121 && \
    pip install pandas numpy matplotlib regex jupyterlab pytorch_memlab tqdm scikit-learn seaborn xgboost lightgbm umap-learn numba pywavelets

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

RUN ldconfig && \
    apt-get -y clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

# Time4Count

This repository provides the full implementation and Docker environment for our journal paper "Round trip time meets transformers: high-fidelity human counting in cluttered environments" submitted to Springer journal(Neural Computing and Applications).

## 📦 Overview

This project introduces a novel approach to indoor people counting by leveraging multivariate time-series data collected from multiple access points using RTT. The neural architecture employs a Conv1D + Transformer and a position-aware weighted cross-entropy loss to improve counting accuracy with Multi-label classification.

## 📁 Directory Structure
```
. ├── Dockerfile # Container definition with CUDA support 
  ├── multilabel_classification_pipeline.ipynb # Main training script 
  ├── sample_data.csv  # CSV-based training/test data 
  ├── requirements.txt # Python Packages
  └── README.md
```


## 🚀 Getting Started

### 1. Build the Docker Container

To build the container with GPU support:

```bash
docker build -t wifi_people_counter .
```

#### 📌 Note: System Environment (Non-Docker Setup)

✅ Base System

 - Operating System: Ubuntu 22.04
 - GPU: NVIDIA GPU (with CUDA support)
 - NVIDIA Driver: Version ≥ 525
 - CUDA Toolkit: 12.0
 - cuDNN: 8.x (compatible with CUDA 12.0)

### 2. Run the Container
Make sure to mount the dataset directories properly:

```
docker run --gpus all -it \
  -v $(pwd):/home/time4count/ \
  --name time_for_count \
  -p 10005:10005 \
  wifi_people_counter bash
```

📌 Note: This Docker container assumes a CUDA 12.0-compatible GPU environment.

### 3. Train/Test the Model
Inside the container, run:

```
jupyter-lab --ip 0.0.0.0 --port=10005 --allow-root --no-browser --ContentsManager.allow_hidden=True &
```
And access localhost:10005 with your browser and run the notebook script(multilabel_classification_pipeline.ipynb).


### Loss

A custom **position-aware weighted cross-entropy loss** is used, which penalizes errors based on the distance between ground truth and predicted positions.

---

## 📊 Evaluation Metrics

- No Error Accuracy  
- ±1 Count Error Rate  
- ±2 Count Error Rate  
- ...

---


## 🔒&📝 Citation and License

This repository is released under the **Academic Non-Commercial License (ANCL)**.

You are free to use, modify, and redistribute this software **for academic research, educational, and personal study purposes only**.  
**Commercial use is strictly prohibited** without prior written permission from the copyright holders.

When using this software in academic work, please cite the corresponding research paper:

> update soon.

The full license text can be found in the [LICENSE](./LICENSE) file.

For commercial licensing inquiries, please contact: [https://yone550.github.io/]

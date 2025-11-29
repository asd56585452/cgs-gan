FROM nvcr.io/nvidia/pytorch:25.10-py3

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    libglm-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy environment file (optional, for reference)
COPY environment.yml /tmp/environment.yml

# Install other dependencies
# PyTorch is already installed in the base image
RUN pip install \
    numpy click pillow scipy requests tqdm ninja matplotlib imageio \
    imageio-ffmpeg==0.4.3 \
    wandb \
    pyspng \
    psutil \
    tensorboard \
    opencv-python \
    plyfile

# Set environment variables for CUDA build
# CUDA_HOME is usually set in NGC containers, but we ensure it
ENV CUDA_HOME=/usr/local/cuda
ENV TORCH_CUDA_ARCH_LIST="8.0 8.6 8.9 9.0 12.0"
ENV LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}
ENV PATH=${CUDA_HOME}/bin:${PATH}

# Clone and install diff-gaussian-rasterization
# Note: We clone into /app/diff-gaussian-rasterization
WORKDIR /app
RUN git clone --recursive https://github.com/ashawkey/diff-gaussian-rasterization
RUN pip install ./diff-gaussian-rasterization

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]

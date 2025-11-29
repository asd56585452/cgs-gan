#!/bin/bash
set -e

# Create directories
mkdir -p data
mkdir -p pretrained_models

# Download pretrained models
echo "Downloading pretrained models..."
if [ ! -f "pretrained_models/ffhqc_512.pkl" ]; then
    wget -O pretrained_models/ffhqc_512.pkl "https://huggingface.co/Fubei/cgs_gan_checkpoints/resolve/main/ffhqc_512.pkl?download=true"
fi

if [ ! -f "pretrained_models/ffhqc_1024.pkl" ]; then
    wget -O pretrained_models/ffhqc_1024.pkl "https://huggingface.co/Fubei/cgs_gan_checkpoints/resolve/main/ffhqc_1024.pkl?download=true"
fi

if [ ! -f "pretrained_models/ffhqc_2048.pkl" ]; then
    wget -O pretrained_models/ffhqc_2048.pkl "https://huggingface.co/Fubei/cgs_gan_checkpoints/resolve/main/ffhqc_2048.pkl?download=true"
fi

if [ ! -f "pretrained_models/ffhq_512.pkl" ]; then
    wget -O pretrained_models/ffhq_512.pkl "https://huggingface.co/Fubei/cgs_gan_checkpoints/resolve/main/ffhq_512.pkl?download=true"
fi

# Download FFHQC dataset
echo "Downloading FFHQC dataset..."
# Use -c to continue download if partially downloaded
wget -c -O data/FFHQC.tar "https://huggingface.co/anonym892312603527/neurips25/resolve/main/FFHQC.tar?download=true"

echo "Extracting FFHQC dataset..."
# Only extract if we haven't already (simple check, can be improved)
if [ ! -d "data/FFHQC" ]; then
    tar -xf data/FFHQC.tar -C data/
fi

echo "Download complete."

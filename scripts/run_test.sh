#!/bin/bash
set -e

# Run inference with pretrained model
echo "Running inference test..."
python generate_samples.py \
    --pkl pretrained_models/ffhqc_512.pkl \
    --num_ids 2 \
    --save_dir results/test_run

echo "Test run complete. Results saved to results/test_run"

# Multistage docker build, requires docker 17.05
# Updated for RTX 5090 (Blackwell) - CUDA 12.8+ required for Blackwell support

# CUDA SDK version, and also a prefix of images' tag.
# Check out the list of officially supported tags:
# https://hub.docker.com/r/nvidia/cuda/tags
# Format: x.y, e.g.: "12.8".
# Required argument.
ARG CUDA=12.8

# builder stage
FROM nvidia/cuda:${CUDA}.0-devel-ubuntu22.04 as builder

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

# CUDA Computational Capability.
# Format: x.y, e.g.: "8.9" for RTX 4090, "10.0" for RTX 5090.
# Required argument.
ARG CCAP=10.0

RUN cd /app && \
  make \
  CUDA=/usr/local/cuda \
  CXXCUDA=/usr/bin/g++ \
  gpu=1 \
  "CCAP=${CCAP}" \
  all

# runtime stage
FROM nvidia/cuda:${CUDA}.0-runtime-ubuntu22.04

COPY --from=builder /app/VanitySearch /usr/bin/VanitySearch

ENTRYPOINT ["/usr/bin/VanitySearch"]

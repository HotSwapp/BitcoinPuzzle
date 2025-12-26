#!/bin/sh

# make sure we run from the root of the repository
[ "$(basename "$PWD")" == "cuda" ] && cd ../..
[ "$(basename "$PWD")" == "docker" ] && cd ..

IMAGE_NAME="${IMAGE_NAME:-vanitysearch}"

# Default arguments - Optimized for RTX 5090 (Blackwell)
# RTX 5090 (Blackwell): CCAP=10.0, CUDA=12.8
# RTX 4090 (Ada):       CCAP=8.9,  CUDA=12.3
# RTX 3090 (Ampere):    CCAP=8.6,  CUDA=12.3
CCAP="${CCAP:-10.0}"
CUDA="${CUDA:-12.8}"

CAPP_MAJOR="${CCAP%.*}"

if [ "${CAPP_MAJOR}" -lt 5 ]; then
    # For 2.x and 3.x branches (legacy)
    DOCKERFILE=./docker/cuda/ccap-2.0.Dockerfile
else
    DOCKERFILE=./docker/cuda/Dockerfile
fi

echo "Building VanitySearch with:"
echo "  CUDA: ${CUDA}"
echo "  CCAP: ${CCAP}"
echo ""

docker build \
    --build-arg "CCAP=${CCAP}" \
    --build-arg "CUDA=${CUDA}" \
    -t "${IMAGE_NAME}:cuda-ccap-${CCAP}" \
    -f "${DOCKERFILE}" .

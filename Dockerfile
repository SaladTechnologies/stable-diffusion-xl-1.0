FROM saladtechnologies/sdnext:latest

ARG MODEL_ID=stabilityai/stable-diffusion-xl-base-1.0
ENV MODEL_ID=${MODEL_ID}
ENV REFINER_MODEL_ID=stabilityai/stable-diffusion-xl-refiner-1.0
ENV CKPT=${DATA_DIR}/models/Stable-diffusion/base/sd_xl_base_1.0.safetensors
ENV REFINER=${DATA_DIR}/models/Stable-diffusion/refiner/sd_xl_refiner_1.0.safetensors

# Get the base model
RUN mkdir -p ${DATA_DIR}/models/Stable-diffusion/base
RUN wget https://huggingface.co/${MODEL_ID}/resolve/main/sd_xl_base_1.0.safetensors \
    -O ${CKPT}

# Get the refiner model
RUN mkdir -p ${DATA_DIR}/models/Stable-diffusion/refiner
RUN wget https://huggingface.co/${REFINER_MODEL_ID}/resolve/main/sd_xl_refiner_1.0.safetensors \
    -O ${REFINER}

ENV HOST='0.0.0.0'
ENV PORT=7860

ENTRYPOINT [  ]
CMD ["/bin/bash", "-c", "${INSTALLDIR}/entrypoint.sh \
    --backend diffusers \
    --use-cuda \
    --no-download \
    --docs \
    --ckpt /webui/data/models/Stable-diffusion/base/sd_xl_base_1.0.safetensors \
    --quick \
    --server-name \"${HOST}\" \
    --port ${PORT}" ]
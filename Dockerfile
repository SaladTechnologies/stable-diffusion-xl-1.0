FROM saladtechnologies/sdnext:latest

ARG MODEL_ID=stabilityai/stable-diffusion-xl-base-1.0
ENV MODEL_ID=${MODEL_ID}
ENV CKPT=${DATA_DIR}/models/Stable-diffusion/model0/sd_xl_base_1.0.safetensors

RUN git clone https://huggingface.co/${MODEL_ID} ${DATA_DIR}/models/Stable-diffusion/model0
RUN wget https://huggingface.co/${MODEL_ID}/resolve/main/sd_xl_base_1.0.safetensors \
    -O ${CKPT}

CMD ["--backend", "diffusers", "--use-cuda", "--no-download", "--listen", "--docs", "--ckpt", "/webui/data/models/Stable-diffusion/model0/sd_xl_base_1.0.safetensors"]
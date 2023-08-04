FROM saladtechnologies/sdnext:latest

ARG MODEL=stabilityai/stable-diffusion-xl-base-1.0
ENV MODEL=${MODEL}

RUN mkdir -p ${DATA_DIR}/models/Stable-diffusion/${MODEL}
RUN wget https://huggingface.co/${MODEL}/resolve/main/sd_xl_base_1.0.safetensors \
    -O ${DATA_DIR}/models/Stable-diffusion/${MODEL}/sd_xl_base_1.0.safetensors

    

CMD ["--backend", "diffusers", "--use-cuda", "--no-download", "--listen", "--docs"]
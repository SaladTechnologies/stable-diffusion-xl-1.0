# stable-diffusion-xl-1.0
This uses the sdnext api container to serve stable diffusion xl 1.0

## Build

```
docker build -t saladtechnologies/sdnext-sdxl10:latest .
```

## Run

```
docker run --gpus all -p 7860:7860 saladtechnologies/sdnext-sdxl10:latest
```
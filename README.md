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

## Enable Refiner

```shell
curl -X 'POST' \
  'http://localhost:7860/sdapi/v1/options' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "sd_model_refiner": "refiner/sd_xl_refiner_1.0.safetensors"
}'
```

## Test

```shell
curl -X 'POST' \
  'http://localhost:7860/sdapi/v1/txt2img' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "prompt": "cat",
  "batch_size": 1,
  "steps": 35,
  "refiner_start": 20,
  "cfg_scale": 7,
  "width": 1216,
  "height": 896,
  "send_images": true,
  "save_images": false
}' \
 -o ./response.json
```

```shell
cat response.json | jq -r '.images[0]' | base64 -d > cat.jpg
```
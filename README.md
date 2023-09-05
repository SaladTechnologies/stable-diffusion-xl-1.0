# stable-diffusion-xl-1.0
This uses the sdnext api container to serve stable diffusion xl 1.0

## Build

```shell
docker buildx build \
-t saladtechnologies/sdnext-sdxl10:latest \
--provenance=false \
--output type=docker \
.
```

## Run

```shell
docker run \
--rm \
--gpus all \
-p 7860:7860 \
-e PORT=7860 \
-e HOST=0.0.0.0 \
saladtechnologies/sdnext-sdxl10:latest
```

For ipv6 networking, make sure you have the network created:
```shell
docker network create --ipv6 --subnet 2001:0DB8::/112 ip6net
```

and then run the container with the network and the host set to `[::]` (ipv6 all interfaces)
```shell
docker run \
--rm \
--gpus all \
-p 7860:7860 \
-e PORT=7860 \
-e HOST='[::]' \
--network="ip6net" \
saladtechnologies/sdnext-sdxl10:latest
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
  "denoising_strength": 0.43,
  "cfg_scale": 7,
  "width": 1216,
  "height": 896,
  "send_images": true,
  "save_images": false,
  "enable_hr": true,
  "hr_second_pass_steps": 35,
  "hr_upscaler": "None"
}' \
 -o ./response.json
```

```shell
cat response.json | jq -r '.images[0]' | base64 -d > cat.jpg
```
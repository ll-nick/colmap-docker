docker run \
    -it \
    --rm \
    --runtime=nvidia \
    --gpus all \
    --group-add $(id -g) \
    --user $(id -u):$(id -g) \
    -v $PROJECT_PATH:/project \
    nickll/colmap

docker run \
    -t \
    --rm \
    --runtime=nvidia \
    --gpus all \
    --group-add $(id -g) \
    --user $(id -u):$(id -g) \
    -v $PROJECT_PATH:/project \
    nickll/colmap \
    xvfb-run colmap automatic_reconstructor --image_path /project/images --workspace_path /project

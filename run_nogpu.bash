docker run \
    -t \
    --rm \
    --group-add $(id -g) \
    --user $(id -u):$(id -g) \
    -v $PROJECT_PATH:/project \
    nickll/colmap \
    colmap automatic_reconstructor --image_path /project/images --workspace_path /project --use_gpu=0


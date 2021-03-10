docker run \
    -it \
    --rm \
    --group-add $(id -g) \
    --user $(id -u):$(id -g) \
    -v $PROJECT_PATH:/project \
    nickll/colmap
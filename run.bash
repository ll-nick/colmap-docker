docker run \
    -t \
    --rm \
    --group-add $(id -g) \
    --user $(id -u):$(id -g) \
    -v $(PROJECT_PATH):/project \
    --runtime=nvidia \
    -e QT_QPA_PLATFORM=offscreen \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix/:/tmp/.X11-unix:ro \
    nickll/colmap \
    colmap automatic_reconstructor --image_path /project/images --workspace_path /project
    

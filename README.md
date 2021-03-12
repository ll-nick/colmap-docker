# colmap-docker

Dockerfile to build dockerized [colmap](https://colmap.github.io/) instance using ll-nick/colmap fork.

## Instructions

### Getting the Docker image
Either pull the image from Dockerhub:
```
docker pull nickll/colmap
```

or build it yourself using the provided Dockerfile:
```
docker build -t yournamespace/colmap .
```

Please note that the colmap version used by this Dockerfile is a fork from colmap and not pulled from the original repo. To change that, edit the Dockerfile accordingly.

### Starting a reconstruction

To run reconstruction, first define the path to the project folder:
```
export PROJECT_PATH=/path/to/project
```

For automatic reconstruction, run:
```
bash run_auto_reconstr.bash
```

For starting the reconstruction (steps) manually, run
```
bash run_interactive.bash
```
to start docker container into an interactive bash.
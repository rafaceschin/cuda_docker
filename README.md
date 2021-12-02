# CUDA Docker
CUDA enabled docker environment for running Keras/TF models
Only requirement (outside of the Docker environment) is the NVIDIA container runtime

# Building:
cd into main directory and run:
docker build -t <tag_name> .


# Command to run at startup

docker run -it --gpus all --user=$UID:$UID -p 8888:8888 -v $(pwd):/data <container_name>

Tip: Set up a bashrc function:
function GPULAB { docker run -it --gpus all --user=$UID:$UID -p 8888:8888 -v $(pwd):/data <container_name>; }

Container boots up a Jupyter lab instance -> follow link in browser to start

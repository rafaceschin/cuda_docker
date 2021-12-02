#FROM nvidia/cuda:10.1-base-ubuntu18.04 
#FROM tensorflow/tensorflow:2.3.0-gpu-jupyter
FROM tensorflow/tensorflow:2.4.1-gpu-jupyter

ENV DEBIAN_FRONTEND=noninteractive

#Base configuration for neurodebian
RUN apt-get update && apt-get install -y\
    wget\
    gnupg\ 
    python3=3.6.7*\
    python3-pip\
    python3-tk=3.6.9*\
    ants=2.2.0*\
    graphviz=2.40.1*\
    liblapack-dev \
    gfortran \
    curl \ 
    npm 
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - &&\
    apt-get install -y nodejs

RUN python3 -m pip install --upgrade pip
# pip
RUN pip3 install \
    wheel \
    numpy==1.19.2 \
#    idna==2.8 \
    networkx>=2.0 \
    traits==4.6.0 \
    nipy==0.4.2 \
    nipype==1.1.9 \
    matplotlib==3.1.1 \
    jupyter \
    jupyterlab==2.1.5 \
    pymc3==3.7 \ 
    theano==1.0.4 \
    graphviz==0.13 \
    arviz==0.4.1 \
    neurocombat-sklearn==0.1.3 \
    sklearn-pandas==1.8.0 \
    seaborn==0.10.0 \
    Pillow==7.2.0 \
    tensorboard \
#    tensorflow>=2.0.0 \
    && jupyter labextension install @axlair/jupyterlab_vim \
    && rm -rf /var/lib/apt/lists/* 

EXPOSE 8888
RUN chmod -R 777 /.local &&\
    mkdir /.theano && chmod -R 777 /.theano &&\
    mkdir ./jupyter

COPY ./.jupyter /.jupyter
RUN chmod -R 777 /.jupyter 
COPY . /app

# Command to run at startup
# run with: 
# docker run -it --gpus all --user=$UID:$UID -p 8888:8888 -v $(pwd):/data <container_name>
# Tip: Set up a bashrc function:
# function GPULAB { docker run -it --gpus all --user=$UID:$UID -p 8888:8888 -v $(pwd):/data <container_name>; }
WORKDIR /data
ENTRYPOINT ["/bin/bash", "/app/startup.sh"]
CMD [""]



# README

This is a re-working of the code found [here](https://github.com/ckmarkoh/neuralart_tensorflow), set up to use Docker and Jupyter notebooks.

## TensorFlow

This repository uses [TensorFlow](https://www.tensorflow.org) to model artistic
style transfer. TensorFlow is fairly simple to install, but if you don't wish
to install it directly on your system, you may run it using containers.

## Docker

To get started for the first time, install [Docker](https://www.docker.com).
Then, create a _docker-machine_. If you haven't done this before, and you are
working on OSX, you can try to use the `start-docker-osx.sh` script:

    $ source start-docker-osx.sh

Note that this script was developed for use with
[Docker Toolbox](https://www.docker.com/products/docker-toolbox) and may not
work with the latest versions of Docker for OSX.

Once the Docker machine exists (here, named 'neuralart'), we can instead start
with

    $ docker-machine start neuralart

When the machine is running, use the following to set environment variables 
appropriately:

    $ eval "$(docker-machine env neuralart)"

To build a Docker image with the Dockerfile in this repository, use

    $ docker build -t <your dockerhub name>/tfjupyter:<version number> .
    $ docker build -t <your dockerhub name>/tfjupyter:latest .

You may push your image to [DockerHub](https://hub.docker.com) with

    $ docker push <your dockerhub name>/tfjupyter:<version number>

once you have an account there. You may retrieve a pre-built image 
anonymously

    $ docker pull gnperdue/tfjupyter

To check the IP address where the Docker machine is running:

    $ docker-machine url neuralart | \
    >     perl -ne '@l=split(":");print split("/",@l[1]);print "\n";'

Forward port 8888 to 5000, locally mount `$PWD` to the `notebooks` directory
in the Docker container:

    $ docker run -p 5000:8888 -v $PWD:/notebooks -it --rm gnperdue/tfjupyter

(Or, instead of `gnperdue`, use your DockerHub username.)

Now, direct your browser to the IP address returned by `docker-machine` earlier
and set the port to 5000, e.g.

    192.168.99.100:5000

To stop, use

    $ docker-machine stop neuralart

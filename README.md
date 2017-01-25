# README

This is a re-working of the code found [here](https://github.com/ckmarkoh/neuralart_tensorflow), set up to use Docker and Jupyter notebooks.

## Docker

    . start-docker-osx.sh

Once the Docker machine exists, we can instead start with

    docker-machine start neuralart
    eval "$(docker-machine env neuralart)"

To build a Docker image, use

    docker build -t <your dockerhub name>/tfjupyter:0.1 .
    docker build -t <your dockerhub name>/tfjupyter:latest .

Or, get a pre-build image

    docker pull gnperdue/tfjupyter

To check the IP address where the Docker machine is running:

    docker-machine url neuralart | \
        perl -ne '@l=split(":");print split("/",@l[1]);print "\n";'

Forward port 8888 to 5000, locally mount `$PWD` to the `notebooks` directory
in the Docker container:

    docker run -p 5000:8888 -v $PWD:/notebooks -it --rm gnperdue/tfjupyter

Now, direct your browser to the IP address returned by `docker-machine` earlier
and set the port to 5000, e.g.

    192.168.99.100:5000

To stop, use

    docker-machine stop neuralart

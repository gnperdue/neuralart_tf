
    . start-docker-osx.sh

Once the Docker machine exists, we can instead start with

    docker-machine start neuralart
    eval "$(docker-machine env neuralart)"

To build a Docker image, use

    docker images
    docker build -t <your dockerhub name>/tfjupyter:0.1 .
    docker build -t gnperdue/tfjupyter:0.1 .

To check the IP address where the Docker machine is running:

    docker-machine url neuralart | \
        perl -ne '@l=split(":");print split("/",@l[1]);print "\n";'

Forward port 8888 to 5000, locally mount `$PWD` to the `notebooks` directory
in the Docker container:

    docker run -p 5000:8888 -v $PWD:/notebooks -it --rm gnperdue/tfjupyter:0.1

To stop, use

    docker-machine stop neuralart

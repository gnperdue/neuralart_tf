## Dockerfile to build DeepQ&A container image

FROM python:3.5.2

## Dependencies

RUN \
  apt-get -qq -y update && apt-get -y install unzip

RUN  \
  pip3 --no-cache-dir install \
  ipykernel \
  jupyter \
  matplotlib \
  numpy \
  scipy \
  scikit-learn \
  scikit-image \
  && \
  python3 -m ipykernel.kernelspec

## Tensorflow
ARG TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0-cp35-cp35m-linux_x86_64.whl

RUN \
  pip3 install -U $TF_BINARY_URL

## Run Config

# TensorBoard
EXPOSE 6006

# IPython
EXPOSE 8888

# "Borrow" `run_jupyter.sh` from Google TF team...
# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

ADD *.ipynb /notebooks/

WORKDIR /notebooks

# start up notebook
CMD ["/run_jupyter.sh", "--NotebookApp.token=''"]

## testing - launch bash
## CMD ["/bin/bash"]

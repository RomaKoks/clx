# An integration test & dev container which builds and installs CLX from default branch
ARG RAPIDS_VERSION=0.19
ARG CUDA_VERSION=10.1
ARG CUDA_SHORT_VERSION=${CUDA_VERSION}
ARG LINUX_VERSION=ubuntu18.04
ARG PYTHON_VERSION=3.7
FROM rapidsai/rapidsai-dev-nightly:${RAPIDS_VERSION}-cuda${CUDA_VERSION}-devel-${LINUX_VERSION}-py${PYTHON_VERSION}

# Add everything from the local build context
ADD . /rapids/clx/
RUN chmod -R ugo+w /rapids/clx/

RUN apt update -y --fix-missing && \
    apt upgrade -y && \
    apt install -y krb5-user

RUN source activate rapids && \
    conda install -c pytorch "pytorch=1.7.1" torchvision "cudf_kafka=${RAPIDS_VERSION}" "custreamz=${RAPIDS_VERSION}" "scikit-learn>=0.21" "nodejs>=12" ipywidgets python-confluent-kafka "transformers=4.*" "seqeval=0.0.12" python-whois seaborn requests matplotlib pytest jupyterlab && \
    pip install "git+https://github.com/rapidsai/cudatashader.git" && \
    pip install mockito && \
    pip install wget && \
    pip install "git+https://github.com/slashnext/SlashNext-URL-Analysis-and-Enrichment.git#egg=slashnext-phishing-ir&subdirectory=Python SDK/src"
    
RUN source activate rapids \
  && conda install -n rapids jupyterlab-nvdashboard \
  && jupyter labextension install @jupyter-widgets/jupyterlab-manager dask-labextension jupyterlab-nvdashboard

# clx build/install
RUN source activate rapids && \
    cd /rapids/clx/python && \
    python setup.py install

WORKDIR /rapids/clx

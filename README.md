# RAPIDSCyber

RAPIDSCyber provides a simple API for analysts, data scientists and engineers to quickly get started with applying [RAPIDS](https://rapids.ai/) to real-world cyber use cases.

## Getting Started

RAPIDSCyber is built around the structure of a Workflow. A Workflow is simply a series of data transformations performed on a gpu [dataframe](https://github.com/rapidsai/cudf) that contains raw cyber data, with the goal of surfacing meaningful cyber analytical output. Data can be read or written to Kafka or a file as part of the Workflow. 

Example Netflow Workflow reading and writing to file:
```python
from rapidscyber.workflow import netflow_workflow

source = {
   "type": "fs",
   "input_format": "csv",
   "input_path": "/path/to/input",
   "schema": ["firstname","lastname","gender"],
   "delimiter": ",",
   "required_cols": ["firstname","lastname","gender"],
   "dtype": ["str","str","str"],
   "header": "0"
}
dest = {
   "type": "fs",
   "output_format": "csv",
   "output_path": "/path/to/output"
}
wf = netflow_workflow.NetflowWorkflow(source=source, destination=dest, name="my-netflow-workflow")
wf.run_workflow()
```


## Installation

### Docker 

RAPIDSCyber 
```aidl
docker build -t rapidscyber .
docker run --runtime=nvidia \
  --rm -it \
  -p 8888:8888 \
  -p 8787:8787 \
  -p 8686:8686 \
  rapidscyber:latest
```

RAPIDSCyber and Kafka
```aidl
docker-compose up
```

### Install from Source

```aidl
# Run tests
pip install pytest
pytest

# Build and install
python setup.py install
```


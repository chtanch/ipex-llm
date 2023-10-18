## Getting started with BigDL LLM on Windows

### Install docker

New users can quickly get started with Docker using this [official link](https://www.docker.com/get-started/).

For Windows users, make sure Hyper-V is enabled on your computer. The instructions for installing on Windows can be accessed from [here](https://docs.docker.com/desktop/install/windows-install/).


### Pull bigdl-llm-cpu image

To pull image from hub, you can execute command on console:
```powershell
docker pull intelanalytics/bigdl-llm-cpu:2.4.0-SNAPSHOT
```
to check if the image is successfully downloaded, you can use:
```powershell
docker images | sls intelanalytics/bigdl-llm-cpu:2.4.0-SNAPSHOT
```


### Start bigdl-llm-cpu container

To run the image and do inference, you could create and run a bat script on Windows.

An example could be:
```bat
@echo off
set DOCKER_IMAGE=intelanalytics/bigdl-llm-cpu:2.4.0-SNAPSHOT
set CONTAINER_NAME=my_container
set MODEL_PATH=D:/llm/models[change to your model path]

:: Run the Docker container
docker run -itd ^
    --net=host ^
    --cpuset-cpus="0-7" ^
    --cpuset-mems="0" ^
    --memory="8G" ^
    --name=%CONTAINER_NAME% ^
    -v %MODEL_PATH%:/llm/models ^
    %DOCKER_IMAGE%
```

After the container is booted, you could get into the container through `docker exec`.
```
docker exec -it my_container bash
```

To run inference using `BigDL-LLM` using cpu, you could refer to this [documentation](https://github.com/intel-analytics/BigDL/tree/main/python/llm#cpu-int4).


### Getting started with chat

chat.py can be used to initiate a conversation with a specified model. The file is under directory '/llm'.

You can download models and bind the model directory from host machine to container when start a container.

After entering the container through `docker exec`, you can run chat.py by:
```bash
cd /llm
python chat.py --model-path YOUR_MODEL_PATH
```
If your model is chatglm-6b and mounted on /llm/models, you can excute:
```bash
python chat.py --model-path /llm/models/chatglm-6b
```
Here is a demostration:
<p align="left">
            <img src="https://llm-assets.readthedocs.io/en/latest/_images/llm-inference-cpu-docker-chatpy-demo.gif" width='60%' /> 

</p>

### Getting started with tutorials

You could start a jupyter-lab serving to explore bigdl-llm-tutorial which can help you build a more sophisticated Chatbo.

To start serving,  run the script under '/llm':
```bash
cd /llm
./start-notebook.sh [--port EXPECTED_PORT]
```
You could assign a port to serving, or the default port 12345 will be assigned.

If you use host network mode when booted the container, after successfully running service, you can access http://127.0.0.1:12345/lab to get into tutorial, or you should bind the correct ports between container and host. 

Here is a demostration of how to use tutorial in explorer:
<p align="left">
            <img src="https://llm-assets.readthedocs.io/en/latest/_images/llm-inference-cpu-docker-tutorial-demo.gif" width='60%' /> 

</p>
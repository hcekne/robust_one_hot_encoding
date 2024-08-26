# Robust One-Hot Encoding
---

This repo showcases a robust way to deal with issues that can come up when doing one-hot-encoding and provides robust solutions.

There are examples and code for both R and Python in the respective folders.

This code is also a supplement to an article I wrote on one-hot encoding which can be found here:

https://medium.com/towards-data-science/robust-one-hot-encoding-930b5f8943af

### How to use

To run the code, either run the code snippets directly on a system where you have the requirements installed. Otherwise, install docker and run the code through docker containers. Use the scripts docker_build_r_container.sh and then docker_run_r.sh to run the R docker container. To enter it and explore the code snippets, go to a terminal and enter the command "docker exec -it <container id>" /bin/bash/" . This will let you use the container interactively. (To find the container ID of the running container, use the command "docker ps -a" at a terminal.)

# Docker snippets

Collection of common Docker commands that are useful for day to day usage. I assume that your user belongs to the `docker` group, hence I 
do not use `sudo` in the commands. If you need to use `sudo` then follow this [guide](https://docs.docker.com/engine/install/linux-postinstall/) 
and start using docker correctly :)

### 1) Remove \<none> images

When building Docker images with `docker build -t <org>:<name> .` the previous versions of the image are "dangling" and marked as \<none>. 
They can quickly accumulate and take a lot of disk space. 

You can use this command to display image hashes that are dangling. Ommit `-q` to display full infomration about images:
```bash
docker images -f "dangling=true" -q
```

To remove these images you can use this command as argument for removal. Following code will remove all dangling images from local registry.
If the image is still used by a container (even stopped) it won't be removed.
```bash
docker rmi $(docker images -f "dangling=true" -q)
```


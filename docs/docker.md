# Docker snippets

Collection of common Docker commands that are useful for day-to-day usage. I assume that your user belongs to the `docker` group, hence I 
do not use `sudo` in the commands. If you need to use `sudo` then follow this [guide](https://docs.docker.com/engine/install/linux-postinstall/) 
and start using docker correctly :)

### 1) Remove \<none> images

When building Docker images with `docker build -t <org>:<name> .` the previous versions of the image are "dangling" and marked as \<none>. 
They can quickly accumulate and take a lot of disk space. 

You can use this command to display image hashes that are dangling. Omit `-q` to display full information about images:
```bash
docker images -f "dangling=true" -q
```

To remove these images you can use this command as an argument for removal. The following code will remove all dangling images from the local registry.
If the image is still used by a container (even stopped), it won't be removed.
```bash
docker rmi $(docker images -f "dangling=true" -q)
```

### 2) Remove all "stopped" (exited) containers

When playing with Docker you will have multiple containers that were run and stopped. However, they are still inside the container registry taking up space. If you want to get rid of them first we need to list them:

This command will display all Container IDs that exited. Read more here: [Filtering docs](https://docs.docker.com/engine/reference/commandline/ps/#filtering),
[Formatting docs](https://docs.docker.com/engine/reference/commandline/ps/#formatting).
```bash
docker ps --filter status=exited --format "{{.ID}}"
```

Now we can use this command's output as input for the removal command:
```bash
docker rm $(docker ps --filter status=exited --format "{{.ID}}" --quiet)
```
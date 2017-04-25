IntelliJ Docker image with gosu and X11-forwarding.

This image is based on [psharkey/intellij's](https://hub.docker.com/r/psharkey/intellij/).
However, it also configures container's user to mimic host's using [gosu](https://github.com/tianon/gosu)
for [handling permissions with docker volumes](https://denibertovic.com/posts/handling-permissions-with-docker-volumes).

This image is conceived to work with two host volumes:

- `$HOME` (mapped into container `$HOME`) with the IntelliJ configuration, and
- `$PWD` (mapped into `/media/workspace`) with the projects to be open by IntelliJ.

Source repository hosted in [github](https://github.com/jesuspv/intellij).

There are two convenient ways to run this image with [X11-forwarded SSH](https://dzone.com/articles/docker-x11-client-via-ssh).

- (a) Run the [`intellij`](https://raw.githubusercontent.com/jesuspv/intellij/master/intellij) script
- (b) Define the following alias in your environment:

```
alias intellij='chmod o+rw $HOME/.Xauthority; \
docker run -it \
   --rm \
   --net=host \
   --env=DISPLAY \
   --env=TZ=Spain/Madrid `# just an example timezone` \
   --volume=$HOME:$HOME:rw \
   --volume=$PWD:/media/host:rw \
   --workdir=/media/host \
   --env USER \
   --env USER_ID=`id --user` \
   --env GROUPS=$(groups | xargs getent group | cut -d: -f1,3 | tr '\n' ',' | sed 's|,$||') \
   --name=intellij.$USER \
   jesuspv/intellij'
```

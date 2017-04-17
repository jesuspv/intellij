IntelliJ Docker image with gosu and X11-forwarding.

Being based on psharkey/intellij's, it differs from phsharkey's
in that it configures container's user to mimic host's using gosu
(https://github.com/tianon/gosu, https://denibertovic.com/posts/handling-permissions-with-docker-volumes).

A convenient way to run it, even through X11-forwarded SSH
(https://dzone.com/articles/docker-x11-client-via-ssh),
is either (a) to run the `intellij` script or (b) to define
the following alias in your environment:

```
alias intellij='chmod o+rw $HOME/.Xauthority; \
docker run -it \
   --rm \
   --net=host \
   --env=DISPLAY \
   --env=TZ=Spain/Madrid \
   --volume=$HOME:$HOME:rw \
   --volume=$PWD:/media/host:rw \
   --workdir=/media/host \
   --env USER \
   --env USER_ID=`id --user` \
   --env GROUPS=$(groups | xargs getent group | cut -d: -f1,3 | tr '\n' ',' | sed 's|,$||') \
   --name=intellij.$USER \
   jesuspv/intellij'
```

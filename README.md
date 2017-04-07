IntelliJ Docker image with gosu and X11-forwarding.

Being based on psharkey/intellij's, it differs from phsharkey's
in that it configures container's user to mimic host's using gosu
(https://github.com/tianon/gosu, https://denibertovic.com/posts/handling-permissions-with-docker-volumes).

A convenient way to run it, even through X11-forwarded SSH
(https://dzone.com/articles/docker-x11-client-via-ssh),
is to define the following alias in your environment:

```
alias intellij='chmod o+rw $HOME/.Xauthority; \
docker run -it \
   --rm \
   --net=host \
   --env=DISPLAY \
   --env=TZ=Spain/Madrid \
   --volume=$HOME/.Xauthority:$HOME/.Xauthority:rw \
   --volume=$HOME/.IdeaIC2016.2 \
   --volume=$HOME/.m2/repository \
   --env USER  --env USER_ID=`id -u` \
   --env GROUP --env GROUP_ID=`id -g` \
   jesuspv/intellij'
```

Notice that this alias requires to have available both:
 (i) a working IntelliJ user profile ($HOME/.IdeaIC2017.1), and
 (ii) a Maven repository ($HOME/.m2/repository) to reuse artifacts.

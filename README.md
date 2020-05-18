# docker
Dockerfiles for building and running the FUNcube source

run build.sh to build all the docker containers.

base-context folder contains tar files of all the source used for the build container, done it this way for now to be sure of a repeatable build. The tar files can be updated (if needed) by running update.sh (first remove the cloned folders go, LimeSuite, funcubeLib).

develop.sh will create you a shell in the build container with the go and funcubeLib directories mounted from outside the container, this allows you to build everything and preserve the results.

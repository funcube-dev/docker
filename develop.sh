CURRENT_DIR=$(dirname $(readlink -f $0))
echo Using path: $CURRENT_DIR

TAG=$(cat $CURRENT_DIR/current_tag)
echo Using tag: $TAG

# create the funcube-net (if it doesn't already exist, will only run once... ever!)
docker network inspect funcube-net > /dev/null || docker network create funcube-net

docker run -ti \
           -p 64513:64513 \
           --rm \
           --privileged \
           --name fcdevelop \
           --network funcube-net \
           -v $CURRENT_DIR/funcubeLib:/funcubeLib \
           -v $CURRENT_DIR/go:/go \
           fcbuild:$TAG

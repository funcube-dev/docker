CURRENT_DIR=$(dirname $(readlink -f $0))
echo Using path: $CURRENT_DIR

TAG=$(cat $CURRENT_DIR/current_tag)
echo Tagging with: $TAG

docker build --tag fcbuild:$TAG --file ./fcbuild.Dockerfile ./base-context

docker build --build-arg FROM_TAG=$TAG  --tag fcdecode:$TAG    --file ./decode.Dockerfile    ./empty-context
docker build --build-arg FROM_TAG=$TAG  --tag fcencode:$TAG    --file ./encode.Dockerfile    ./empty-context
docker build --build-arg FROM_TAG=$TAG  --tag limetx:$TAG      --file ./limetx.Dockerfile    ./empty-context
docker build --build-arg FROM_TAG=$TAG  --tag fcwarehouse:$TAG --file ./warehouse.Dockerfile ./empty-context
docker build --build-arg FROM_TAG=$TAG  --tag fcrun:$TAG       --file ./fcrun.Dockerfile     ./empty-context

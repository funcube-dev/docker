#!/bin/bash

CURRENT_DIR=$(dirname $(readlink -f $0))
echo Using path: $CURRENT_DIR

DEST_PATH="$CURRENT_DIR/LimeSuite"
if [ ! -d "$DEST_PATH" ]; then
  echo "******* UPDATING - $DEST_PATH"
  git clone --depth 1 --branch v20.01.0 git://github.com/myriadrf/LimeSuite.git && \
    tar --exclude .git \
        -cvzf LimeSuite.tar.gz LimeSuite/ && \
    rm $CURRENT_DIR/base-context/LimeSuite.tar.gz && \
    mv LimeSuite.tar.gz $CURRENT_DIR/base-context/ && \
    echo "******* SUCCESS - LimeSuite updated *******"
else
  echo "******* SKIPPING - To update remove directory: $DEST_PATH"
fi

DEST_PATH="$CURRENT_DIR/go"
if [ ! -d "$DEST_PATH" ]; then
  echo "******* UPDATING - $DEST_PATH"
  git clone --depth 1 git://github.com/funcube-dev/go.git && \
    tar --exclude .git \
        -cvzf go.tar.gz go/ && \
    rm $CURRENT_DIR/base-context/go.tar.gz && \
    mv go.tar.gz $CURRENT_DIR/base-context/ && \
    echo "******* SUCCESS - go code updated *******"
else
  echo "******* SKIPPING - To update remove directory: $DEST_PATH"
fi

DEST_PATH="$CURRENT_DIR/funcubeLib"
if [ ! -d "$DEST_PATH" ]; then
  echo "******* UPDATING - $DEST_PATH"
  git clone --depth 1 git://github.com/funcube-dev/funcubeLib.git && \
    tar --exclude .git \
        -cvzf funcubeLib.tar.gz funcubeLib/ && \
    rm $CURRENT_DIR/base-context/funcubeLib.tar.gz && \
    mv funcubeLib.tar.gz $CURRENT_DIR/base-context/ && \
    echo "******* SUCCESS - funcubeLib updated *******"
else
  echo "******* SKIPPING - To update remove directory: $DEST_PATH"
fi

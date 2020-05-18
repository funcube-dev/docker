CURRENT_DIR=$(dirname $(readlink -f $0))
echo Using path: $CURRENT_DIR

git clone --depth 1 --branch v20.01.0 git@github.com:myriadrf/LimeSuite.git
git clone --depth 1 git@github.com:funcube-dev/funcubeLib.git
git clone --depth 1 git@github.com:funcube-dev/go.git

rm $CURRENT_DIR/base-context/funcubeLib.tar.gz
rm $CURRENT_DIR/base-context/go.tar.gz
rm $CURRENT_DIR/base-context/LimeSuite.tar.gz

tar --exclude .git \
    -cvzf funcubeLib.tar.gz funcubeLib/

tar --exclude .git \
    -cvzf go.tar.gz go/

tar --exclude .git \
    -cvzf LimeSuite.tar.gz LimeSuite/

mv funcubeLib.tar.gz $CURRENT_DIR/base-context/
mv go.tar.gz $CURRENT_DIR/base-context/
mv LimeSuite.tar.gz $CURRENT_DIR/base-context/

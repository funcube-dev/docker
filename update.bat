echo Using path:
cd
git clone --depth 1 --branch v20.01.0 git@github.com:myriadrf/LimeSuite.git
git clone --depth 1 git@github.com:funcube-dev/funcubeLib.git
git clone --depth 1 git@github.com:funcube-dev/go.git

del .\base-context\dashboard.tar.gz
del .\base-context\go.tar.gz
del .\base-context\LimeSuite.tar.gz

tar -cvz --exclude .vs --exclude .vscode --exclude bin --exclude Debug --exclude Release --exclude Win -f funcubeLib.tar.gz .\funcubeLib\*.*
tar -cvzf go.tar.gz go\*.*
tar -cvzf LimeSuite.tar.gz LimeSuite\*.*

move funcubeLib.tar.gz .\base-context\
move go.tar.gz .\base-context\
move LimeSuite.tar.gz .\base-context\

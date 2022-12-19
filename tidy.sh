BASE=$(
    cd "$(dirname "$0")"
    pwd -P
)
set -e
rm -fr $(find $BASE -name .make)
rm -fr $(find $BASE -name .dart)
rm -fr $(find $BASE -name .pub-cache)
rm -fr $(find $BASE -name .dart_tool)
rm -fr $(find $BASE -name .VSC*)
rm -fr $(find $BASE -name .packages)
rm -fr $(find $BASE -name pubspec.lock)
rm -fr $(find $BASE -name target)
rm -fr $(find $BASE -name .vscode)
rm -fr $(find $BASE -name artifacts)
rm -fr $(find $BASE -name node_modules)

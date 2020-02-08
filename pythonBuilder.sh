#/bin/bash
set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately

SOURCE_DOWNLOAD_DIR="$HOME/src"
TARGET_BUILD_DIR="$HOME/.localpython"

##############################################################################
# NO NEED TO EDIT BELOW THIS LINE
SCRIPT_VERSION=0.0.1
SCRIPT_DATE=2020-02-08

echo "Starting the Python builder."

# Collect required versions from user
# Python
read -p "Python version? [3.8.1]: " python_version
PYTHON_VERSION=${python_version:-'3.8.1'}
PYTHON_SOURCE_URL="https://www.python.org/ftp/python"
DOWNLOAD_URL="$PYTHON_SOURCE_URL/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz"

# Remove source files?
while ! [[ "$remove_source" =~ ^(Yes|No)$ ]] 
do
  read -p "Remove source files after build? (Yes/No)? [Yes]: " remove_source
  if [ -z $remove_source ];then
    remove_source="No"
  fi
done 
REMOVE_SOURCE=${remove_source:-'Yes'}


mkdir -p $SOURCE_DOWNLOAD_DIR
cd $SOURCE_DOWNLOAD_DIR
echo "Download source for Python $PYTHON_VERSION"
# Removing any old files of the same name if present
if [ -f "Python-$PYTHON_VERSION.tgz" ] ; then
    rm "Python-$PYTHON_VERSION.tgz"
fi
wget -q $DOWNLOAD_URL

if [ $? -ne 0 ]
then
    echo ""
    echo "Error downloading source files"
    echo "Check that $PYTHON_VERSION is a valid version number at $PYTHON_SOURCE_URL"
    exit 1
fi

echo "Extracting source files for Python $PYTHON_VERSION"
tar -zxf "Python-$PYTHON_VERSION.tgz"
cd "Python-$PYTHON_VERSION"

mkdir -p "$TARGET_BUILD_DIR/$PYTHON_VERSION"

./configure CPPFLAGS="-I/usr/local/opt/openssl/include" LDFLAGS="-L/usr/local/opt/openssl/lib" PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig" --prefix="$TARGET_BUILD_DIR/$PYTHON_VERSION"

make
make install

echo "Compilation of Python $PYTHON_VERSON is complete, you can find you binary at $TARGET_BUILD_DIR/$PYTHON_VERSION/bin/"

if [ $REMOVE_SOURCE == "Yes" ]
then
    rm "$TARGET_BUILD_DIR/Python-$PYTHON_VERSION.tgz"
    rm -rf "$SOURCE_DOWNLOAD_DIR/Python-$PYTHON_VERSION"
    echo "Source files have been removed"
fi
exit 0
# Summary

A quick script to download and build Python from source, including OpenSSL which is required for pip commands

# Usage
```
./pythonBuilder.sh
```
Once run, it will ask two questions as shown below.

You are expected to know the version you want to install exists and is available.

The second question will remove any source files that were downloaded as part of the build process.
```
Starting the Python builder.
Python version? [3.8.1]:
Remove source files after build? (Yes/No)? [Yes]:
```

# Options
There are currently two options (variables) that can be changed from within the script itself:

|Variable Name|Description|
|----|----|
|`SOURCE_DOWNLOAD_DIR`|This defines where the source files will be downloaded to|
|`TARGET_BUILD_DIR`|This is where the built binaries will end up|

These can be changed as required, however the source files are automatically removable if required on script run.

____
[Released under GNU GPL v3](LICENSE)
- Author: Dan Streeter
- Last Updated: 2020-02-08 14:25
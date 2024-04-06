#!/bin/bash

# Load the installed_path from package.json
package_json_path=$1
package_dir=$2
# Use jq to extract the installed_path from package.json
export INSTALLED_PATH=$(jq -r '.installed_path' $package_json_path)

# Define the GitHub repository details
OWNER="dylanaraps"
REPO="neofetch"
REF="master"
export TEMP_DIR=/tmp/$REPO
mkdir -p $TEMP_DIR
# Download the tarball from GitHub
curl -L "https://api.github.com/repos/$OWNER/$REPO/tarball/$REF" -o package.tar.gz

# Extract the tarball to the installed_path
tar -xzf package.tar.gz -C "$TEMP_DIR"/ --strip-components=1

# Change directory to the extracted project
cd $TEMP_DIR

# Run make to build the project
make

# Move the binaries to the installed_path
# Assuming the binaries are in a directory named 'bin'
mv $TEMP_DIR/neofetch "$INSTALLED_PATH"

# Clean up the downloaded tarball and the temporary directory

rm -rf "$TEMP_DIR"
#rm $package_dir/package.tar.gz

#!/bin/sh

########################################
# Setup app development environment
########################################
# Create a virtualenv for our Python packages, then
# install the packages as specified in requirements.txt.
# This script should be run as the vagrant user.
########################################

echo "Setting up the app virtualenv"
. `which virtualenvwrapper.sh`
mkvirtualenv app
cd /vagrant/app
pip install -r requirements.txt
echo "virtualenv setup complete!"
echo "Now start the server with"
echo "  foreman start"
echo "inside the app directory."

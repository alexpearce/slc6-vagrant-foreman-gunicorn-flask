#!/bin/sh

########################################
# User provisioning
########################################
# Configure the vagrant user's login shell (bash), install pip, rbenv,
# and a Ruby.
# This script should be executed by the vagrant user
#   su vagrant -c '/vagrant/user_provisioning.sh'
########################################

echo "Starting user provisioning"

# Set up ROOT/PyROOT by sourcing software on AFS
echo "Configuring shell"
cat >> $HOME/.bashrc << EOF

GCC=/afs/cern.ch/sw/lcg/external/gcc/4.8/x86_64-slc6-gcc48-opt
ROOT=/afs/cern.ch/sw/lcg/app/releases/ROOT/5.34.14/x86_64-slc6-gcc48-opt/root
PYTHON=/afs/cern.ch/sw/lcg/external/Python/2.7.4/x86_64-slc6-gcc48-opt
source \$GCC/setup.sh
source \$ROOT/bin/thisroot.sh
PATH=\$PYTHON/bin:\$HOME/.local/bin:\$PATH
LD_LIBRARY_PATH=\$PYTHON/lib:\$LD_LIBRARY_PATH

export PATH
export LD_LIBRARY_PATH

EOF
source $HOME/.bash_profile

echo "Setting up pip and virtualenv"
curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py > $HOME/get-pip.py
python $HOME/get-pip.py --user
pip install --user virtualenv virtualenvwrapper
rm -f $HOME/get-pip.py
# Set up for virtualenvwrapper
echo "export WORKON_HOME=\$HOME/virtualenvs" >> .bashrc
echo "source \$HOME/.local/bin/virtualenvwrapper.sh" >> .bashrc
mkdir -p $HOME/virtualenvs

echo "Installing rbenv and Ruby"
git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bashrc
echo 'eval "$(rbenv init -)"' >> $HOME/.bashrc
source $HOME/.bash_profile
rbenv install 1.9.3-p484
rbenv global 1.9.3-p484
# Don't install ri and rdoc documentation when installing gems
echo "gem: --no-rdoc --no-ri" > $HOME/.gemrc

echo "Installing Foreman"
gem install foreman

echo "User provisioning complete!"

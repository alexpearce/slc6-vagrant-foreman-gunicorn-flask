SLC6 + Vagrant + Foreman + Gunicorn + Flask
===========================================

These files are all that's needed to create an [SLC6 ](https://www.scientificlinux.org/) development environment with [Vagrant](http://www.vagrantup.com/).
There are three classes of file:

1. The `Vagrantfile` specifies how to create and provision the virtual machine (VM),
2. The `*_provision.sh` files define the provisioning which sets up the VM, and
3. `setup_velo.sh` is application-specific configuration for running a Flask app, serverd by Gunicorn, with Foreman managing the processes.

To initialise the virtual machine, install [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://docs.vagrantup.com/v2/installation/index.html) and then, inside this repository, run

    vagrant up --provision

and then when prompted to reload, do so with

    vagrant reload --provision

Both of these steps can take some time, upwards of ten minutes.

If you then want to run a web application, SSH into the VM

    vagrant ssh

and run the `setup_app.sh` script

    /vagrant/setup_app.sh

To start the server, in the VM do

    workon app
    cd /vagrant/app
    foreman start

Then [visit the site](http://localhost:5000/) on your development machine.

The App
-------

The `setup_app.sh` script assume there's a [Flask](http://flask.pocoo.org/) app in the `app/` directory, along with a [pip](https://pip.readthedocs.org/en/latest/) [`requirements.txt`](https://pip.readthedocs.org/en/latest/user_guide.html#requirements-files) file defining the app's dependencies, and a [Foreman](http://ddollar.github.io/foreman/) [`Procfile`](http://ddollar.github.io/foreman/#PROCFILE) that defines the app's processes.

An example app is included for completeness.

Caveats
-------

This Vagrant configuration was created for an app that required the [ROOT](http://root.cern.ch/drupal/) framework to run, and so the configuration installs dependencies to source and run ROOT.

Namely, an [OpenAFS](https://www.openafs.org/) client is installed to access ROOT (and Python, to use [PyROOT](http://root.cern.ch/drupal/content/pyroot)) over AFS.
This means there's no need to install ROOT locally, included all the development requirements.

The only dependency for *running* ROOT locally, which is installed, is `libXpm`. [XRootD](http://xrootd.org/) is also installed in order to access files on [The Grid](http://wlcg.web.cern.ch/).

Nevertheless, you don't need any special permissions to access ROOT and Python over AFS, so leaving the provisioning unchanged will allow your VM to run perfectly fine.

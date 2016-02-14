# Apache Spark VM

Automated scripts to provision a virtual machine for Apache Spark development.

Uses Vagrant with a simple Bash provisioner script to create an Ubuntu VM with
the following installed:

* Ubuntu 15.10
* Desktop environment: XFCE 4 (Xubuntu Core)
* Apache Spark 1.6.0 pre-built for Hadoop 2.6 (binary)
* Java: OpenJDK 8 (Ubuntu package)
* Maven 3 (Ubuntu package)
* Scala 2.10.6 (binary)
* SBT 0.13.9 (binary)
* Python 2.7 (Ubuntu package)

## Caching

To speed up builds by caching downloaded Debian packages on your host machine,
run this first:

    vagrant plugin install vagrant-cachier

Note that the provioner script will download binary packages (e.g. Spark) to the
`./cache` directory on your host. This is done to avoid repeated downloads in a
similar way to how vagrant-cachier works for Linux packages. In particular, it
avoids you downloading the 270+ MB Spark distribution every build!

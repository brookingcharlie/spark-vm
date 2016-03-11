#!/bin/bash

sed -i "s,http://archive.ubuntu.com/,http://au.archive.ubuntu.com/,g" /etc/apt/sources.list
apt-get update
apt-get dist-upgrade -y

apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

apt-get install -y xubuntu-core chromium-browser
echo 'set background=dark' >> /home/vagrant/.vimrc

apt-get install -y openjdk-8-jdk maven

apt-get install -y python2.7

# Create a cache folder under /vagrant, which mounts the host filesystem.
# This means we won't have to re-download large binaries (e.g. Spark 1.6 is 276 MB)
# when running vagrant up after a vagrant destroy. Note that we rely on the 'continue'
# option of wget and HTTP server support for this to work.
mkdir -p /vagrant/cache

# We could apt-get install scala but the Ubuntu package is currently at verson 2.11.
# Using Scala 2.11 with Spark requires downloading the Spark source distribution and
# building with Scala 2.11 support; but we're just using a Spark binary for this VM.
# See latest Scala downloads at http://www.scala-lang.org/download/.
if [[ ! -e '/opt/scala-2.10.6' ]]; then
  wget -c -P /vagrant/cache 'http://downloads.typesafe.com/scala/2.10.6/scala-2.10.6.tgz'
  tar -x -z -C /opt -f '/vagrant/cache/scala-2.10.6.tgz'
  chown -R vagrant: '/opt/scala-2.10.6'
  ln -s 'scala-2.10.6' '/opt/scala'
  echo 'export PATH="/opt/scala/bin:$PATH"' >> /home/vagrant/.bashrc
fi

# See latest SBT downloads at http://www.scala-sbt.org/download.html.
if [[ ! -e '/opt/sbt' ]]; then
  wget -c -P /vagrant/cache 'https://dl.bintray.com/sbt/native-packages/sbt/0.13.9/sbt-0.13.9.tgz'
  tar -x -z -C /opt -f '/vagrant/cache/sbt-0.13.9.tgz'
  chown -R vagrant: '/opt/sbt'
  echo 'export PATH="/opt/sbt/bin:$PATH"' >> /home/vagrant/.bashrc
fi

# See latest Spark downloads at http://spark.apache.org/downloads.html.
if [[ ! -e '/opt/spark-1.6.0-bin-hadoop2.6' ]]; then
  wget -c -P /vagrant/cache 'http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-hadoop2.6.tgz'
  tar -x -z -C /opt -f '/vagrant/cache/spark-1.6.0-bin-hadoop2.6.tgz'
  chown -R vagrant: '/opt/spark-1.6.0-bin-hadoop2.6'
  ln -s 'spark-1.6.0-bin-hadoop2.6' '/opt/spark'
  echo 'export PATH="/opt/spark/bin:$PATH"' >> /home/vagrant/.bashrc

  # Configure logging to remove excessive WARN messages in spark-shell.
  # See http://stackoverflow.com/q/33996879.
  cp /opt/spark/conf/log4j.properties.template /opt/spark/conf/log4j.properties
  sed -i 's/log4j.rootCategory=INFO/log4j.rootCategory=ERROR/' /opt/spark/conf/log4j.properties
fi

reboot # to start X display manager

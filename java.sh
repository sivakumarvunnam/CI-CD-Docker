#!/bin/bash
set -eu

function installJava() {
    if ! [ -x "$(command -v java)" ]; then
    echo 'Error: Java is not installed.' >&2
 else
    echo "Instaling Java..."
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install -y openjdk-8-jre-headless
    JAVA_HOME=`readlink -e $(which java)`
    export PATH=$PATH:$JAVA_HOME
    echo "Java home : ${JAVA_HOME}"
  fi
}

installJava

#!/bin/bash

## Script for setting up spring and docker environments on OSX

function usage() {
  echo "Usage: "
  echo "./setup.sh <option>"
  echo ""
  echo "Options: "
  echo "install - install docker and gradle packages using homebrew."
  echo "build - build the spring boot .jar file and docker image."
  echo "run <image-id> - run the suppplied docker image."
  echo ""
}

function install_homebrew() {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function build_jar() {
  cd $ROOT_DIR/spring
  ./gradlew build
}

function copy_jar() {
  cd $ROOT_DIR
  cp spring/build/libs/*.jar docker/
}

function build_docker() {
  cd $ROOT_DIR/docker
  docker build ./
}

function run_docker() {
  docker run --expose $TOMCAT_PORT -p $TOMCAT_PORT:$TOMCAT_PORT $1
}

function verify_image() {
  if [ -z "$1" ]; then
    echo "No docker image specified!  Run docker image ls to get a list of images."
    exit 1
  elif ! docker image ls | grep -o " $1 "; then
    echo "Docker image specified does not exist!  Check docker image ls for a list of images."
    exit 1
  fi
}

ROOT_DIR=`pwd`
TOMCAT_PORT="8080"

case "$1" in

  "install")
    install_homebrew
    brew install gradle
    brew cask install docker
    ;;

  "build")
    build_jar
    copy_jar
    build_docker
    ;;

  "run")
    verify_image $2
    run_docker $2
    ;;

  ""|"*")
    usage
    ;;

esac

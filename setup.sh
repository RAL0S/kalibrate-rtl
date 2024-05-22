#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${RALPM_TMP_DIR}" ]]; then
    echo "RALPM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_INSTALL_DIR}" ]]; then
    echo "RALPM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_BIN_DIR}" ]]; then
    echo "RALPM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/RAL0S/kalibrate-rtl/releases/download/v0.4.1/kal -O $RALPM_TMP_DIR/kal
  mv $RALPM_TMP_DIR/kal $RALPM_PKG_INSTALL_DIR
  chmod +x $RALPM_PKG_INSTALL_DIR/kal
  ln -s $RALPM_PKG_INSTALL_DIR/kal $RALPM_PKG_BIN_DIR/kal
  echo "This package adds the command: kal"
}

uninstall() {
  rm $RALPM_PKG_BIN_DIR/kal
  rm $RALPM_PKG_INSTALL_DIR/kal
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1
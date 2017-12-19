#!/bin/bash

# function
# ----------------------------
PROGRAMNAME=$(basename $0)
function show_help() {

  echo "Usage:"
  echo "  ${PROGRAMNAME} [-c|--config-type <local|publish>] [-t|--theme-name theme_name] "
  echo
  echo "Options:"
  echo "  -c, --config-type       choice of pelicanconf type."
  echo "                           local: use pelicanconf.py, publish: publishconf.py"
  echo "                           [default: local]"
  echo "  -t, --theme-name         theme name under /theme in docker container."
  echo

}

# option parse
# ----------------------------
CONFIG_TYPE=${1:-local}
THEME_NAME=

for OPT in "$@"
do
  case $OPT in
    '-h'|'--help')
      show_help
      exit 1
      ;;
    '-c'|'--config-type')
      if [[ -z $2 ]] || [[ $2 =~ ^-+ ]]; then
        echo "${PROGRAMNAME}: option requires an argument "local" or "publish" -- $1" 1>&2
        exit 1
      fi
      CONFIG_TYPE=$2
      shift 2
      ;;
    '-t'|'--theme-name')
      if [[ -z $2 ]] || [[ $2 =~ ^-+ ]]; then
        echo "${PROGRAMNAME}: option requires an argument for theme name -- $1" 1>&2
        exit 1
      fi
      THEME_NAME="/$2"
      shift 2
      ;;
  esac
done

case $CONFIG_TYPE in
  'local')
    PELICANCONF="pelicanconf.py"
    ;;
  'publish')
    PELICANCONF="publishconf.py"
    ;;
esac

# main
# -----------------------------
trap 'unlink pelican_plugins' 1 2 3 15

ln -sv /pelican-plugins .
/usr/bin/pelican \
  --settings ${PELICANCONF} \
  --theme-path /theme${THEME_NAME} \
  /sitesrc/content
unlink pelican-plugins

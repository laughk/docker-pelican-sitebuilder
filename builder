#!/bin/bash

# default parameter
# ----------------------------
CONFIG_TYPE=${1:-local}
USE_THEME_PATH=
PELICAN_THEME_OPTION=

# function
# ----------------------------
PROGRAMNAME=$(basename $0)
function show_help() {

  echo "Usage:"
  echo "  ${PROGRAMNAME} [-c|--config-type <local|publish>] [-t|--official-theme theme_name] [-T|--my-theme]"
  echo
  echo "Options:"
  echo "  -c, --config-type        choice of pelicanconf type."
  echo "                             - local: use pelicanconf.py"
  echo "                             - publish: publishconf.py"
  echo "                           [default: local]"
  echo
  echo "  -t, --official-theme     theme name in https://github.com/getpelican/pelican-themes."
  echo "                           [default: ]"
  echo "                           (can't use with -T/--my-theme)"
  echo
  echo "  -T, --my-theme           theme name under /my-theme in docker container."
  echo "                           [default: ]"
  echo "                           (can't use with -t/--official-theme)"
  echo

}

# option parse
# ----------------------------
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
    '-T'|'--my-theme')
      if [[ ! -z ${OFFICIAL_THEME} ]]; then
        echo "${PROGRAMNAME}: option \"-T/--my-theme\" and \"-t/--oficial-theme\" are not able to use at the same time."
        exit 1
      fi
      USE_THEME_PATH="/my-theme"
      shift 1
      ;;
    '-t'|'--official-theme')
      if [[ -z $2 ]] || [[ $2 =~ ^-+ ]]; then
        echo "${PROGRAMNAME}: option requires an argument for theme name -- $1" 1>&2
        exit 1
      elif [[ ! -z ${THEME_NAME} ]]; then
        echo "${PROGRAMNAME}: option \"-T/--my-theme\" and \"-t/--oficial-theme\" are not able to use at the same time."
        exit 1
      fi
      USE_THEME_PATH="/pelican-themes/$2"
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

[[ ! -z ${USE_THEME_PATH} ]] && {
  PELICAN_THEME_OPTION="--theme-path ${USE_THEME_PATH}"
}

# main
# -----------------------------
trap 'unlink pelican-plugins' 1 2 3 15

ln -sv /pelican-plugins .
/usr/bin/pelican \
  --settings ${PELICANCONF} \
  ${PELICAN_THEME_OPTION} \
  /project-root/content
unlink pelican-plugins

#!/usr/bin/env python
# -*- coding:utf-8 -*-

import sys
sys.path.append('/sitesrc')
from publishconf import *


if PLUGIN_PATHS:
    PLUGIN_PATHS.append('/pelican-plugins')
else:
    PLUGIN_PATHS = ['/pelican-plugins']

THEME = '/theme'
OUTPUT_PATH = '/sitesrc/output'

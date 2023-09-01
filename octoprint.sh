#!/bin/bash

#Print Commands
set +x
set -o xtrace

~/OctoPrint/venv/bin/octoprint serve &

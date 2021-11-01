#!/bin/bash

#Print Commands
set +x
set -o xtrace

destination=$1
message=$2

echo "$message" | msmtp $destination
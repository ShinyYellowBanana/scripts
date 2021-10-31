#!/bin/sh

destination=$1
message=$2

echo "$message" | msmtp $destination
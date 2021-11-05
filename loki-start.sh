#!/bin/bash
#
# loki start script

nohup ./loki -config.file=loki-config.yaml > error.log 2>&1 &

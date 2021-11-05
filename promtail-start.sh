#!/bin/bash
#
# promtail start script

nohup ./promtail -config.file=promtail-config.yaml > error.log 2>&1 &

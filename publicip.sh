#!/bin/bash
##  this is a short script to find your public IP  via CLI
##  this was found at: https://www.cyberciti.biz/faq/how-to-find-my-public-ip-address-from-command-line-on-a-linux/

dig +short myip.opendns.com @resolver1.opendns.com

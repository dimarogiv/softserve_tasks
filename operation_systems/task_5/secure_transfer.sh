#!/bin/bash

ssh -p3002 -oRequestTTY=no -i ~/.ssh/id_ed25519 vagrant@localhost mkdir -p backup
scp -P3002 -oRequestTTY=no -i ~/.ssh/id_ed25519 -r data/* vagrant@localhost:backup

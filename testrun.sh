#!/bin/bash

## Run all the images one after another
## and see what happens...

for i in $(grep '^    image:' docker-compose.yaml | cut -c12-)
do
	echo
	echo "======= $i ======="
	docker run --interactive --tty --rm $i
done

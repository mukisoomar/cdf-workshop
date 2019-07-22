#!/bin/bash

./generate-clickstream-data.sh $1 | ncat localhost 9797

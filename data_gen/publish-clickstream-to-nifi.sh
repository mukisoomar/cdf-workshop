#!/bin/bash

./generate-clickstream-data.sh | ncat localhost 9797

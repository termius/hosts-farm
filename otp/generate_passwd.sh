#!/bin/bash

docker exec -it --user sa $(docker-compose ps -q otp) otpw-gen | tee otp/keys.txt
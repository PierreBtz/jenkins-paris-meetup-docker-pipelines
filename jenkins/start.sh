#!/usr/bin/env bash

docker run --name jenkins -v /var/run/docker.sock:/var/run/docker.sock -p 80:8080 pierrebtz/paris-meetup-pipeline-docker-jenkins:1.0.0

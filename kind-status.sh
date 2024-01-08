#!/bin/bash

OPTION=$1

case $OPTION in 
	"start")
	for i in $(docker ps -aq); do docker start $i; done
	;;


	"status")
	docker ps -a
	;;

	"stop")
	for i in $(docker ps -aq); do docker stop $i; done
	;;

	*)
	echo "start | status | stop"
	;;

esac	

#!/bin/bash
# States are:
# 1 = Idle
# 2 = Arming
# 3 = Armed
# 4 = Charging
# 5 = Balancing
# 6 = Active
# 7 = Error
#
# To arm, set state to 3

if [ "$#" -eq 0 ]; then
    curl http://localhost:6060/api/v1/state
elif [ "$#" -eq 1 ]; then
    echo "Should set status to $1"
    body='{"state":'$1'}'
    # echo "Body: " $body
	 curl -X POST -H "Content-Type: application/json" -d $body http://localhost:6060/api/v1/state
else
   echo "$# parameters not allowed, only 0 or 1."
fi
   

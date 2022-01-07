#!/bin/sh

while true; do

        ping -I ppp0 -c 1 8.8.8.8 -s 0

        if [ $? -eq 0 ]; then
                echo "Connection up, reconnect not required..."
        else
                echo "Connection down, reconnecting..."
                sudo ifconfig wwan0 down
                gpio -g mode 7 out
                gpio -g write 7 1
                sleep 1.5
                gpio -g write 7 0
                sleep 10
                gpio -g write 7 0
                sleep 1.2
                gpio -g write 7 1
                sleep 0.3
                gpio -g write 7 0
                sleep 5
                sudo pon
        fi

        sleep 10
done

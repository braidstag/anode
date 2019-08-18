#!/bin/sh
gpio unexportall
echo raise gpio pin to hold power on
gpio -g mode 16 out
gpio -g write 16 1
echo flash fusebits
sudo avrdude -p atmega328p -C /home/pi/braidstag/config/avrdude_gpio.conf -c pi_1 -U lfuse:w:0xFF:m
echo flash firmware
sudo avrdude -p atmega328p -C /home/pi/braidstag/config/avrdude_gpio.conf -c pi_1 -v -U flash:w:/home/pi/braidstag/arduino-milestag/hex/IRcomms.ino.with_bootloader.hex:i
echo Sleep
sleep 10
echo Drop pin
gpio -g write 16 0

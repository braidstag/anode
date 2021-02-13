#!/bin/sh -e

cd /home/pi/braidstag/arduino-milestag/IRcomms
echo Compile
make

echo raise gpio pin to hold power on
gpio unexportall
gpio -g mode 16 out
gpio -g write 16 1

export AVRDUDE_CONF=/home/pi/braidstag/config/avrdude_gpio.conf
export AVRDUDE_ARD_PROGRAMMER=gpio
export MONITOR_PORT=/dev/ttyS0

echo flash fusebits
#sudo avrdude -p atmega328p -C /home/pi/braidstag/config/avrdude_gpio.conf -c pi_1 -U lfuse:w:0xFF:m
ISP_LOW_FUSE=0xff make set_fuses

echo flash firmware
#sudo avrdude -p atmega328p -C /home/pi/braidstag/config/avrdude_gpio.conf -c pi_1 -v -U flash:w:/home/pi/braidstag/arduino-milestag/hex/IRcomms.ino.with_bootloader.hex:i
make upload

echo Sleep
sleep 10

echo Drop power pin
gpio -g write 16 0

echo Done

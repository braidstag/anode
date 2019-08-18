## Ansible-stuff

Configurations for the ansible deployment of braidstag. 

## Quick start

* flash an sd card with a fresh rasbian-lite image
* Add a blank file called `ssh` to the boot partition
* Plug into ethernet
* Note its ip address.
* set the hostname as per the example below
* ensure that hostname is present in the inventory (`live.hosts` file)
* run the meshtag playbook as per the example below

## Example uses

Set the hostname for 192.168.0.151 (interactively)
`ansible-playbook -i 192.168.0.151, hostname.yml --extra-vars "ansible_user=pi ansible_password=raspberry ansible_ssh_extra='-o StrictHostKeyChecking=no'" --become`

Meshtag setup
`ansible-playbook -i live.hosts meshtag.yml`

Mesahtag setup for a single host
`ansible-playbook -i live.hosts meshtag.yml -l gun1`

Shutdown all machines
`ansible -i live.hosts all -a "/sbin/shutdown" --become`

Flash all guns (or run any role on any group or host)
`ansible -i live.hosts guns -m include_role -a name=flash`

set atmega328p fuses to use 17mhz external oscillator
`sudo avrdude -p atmega328p -C /etc/avrdude_gpio.conf -c pi_1 -U lfuse:w:0xFF:m`

## Useful links

[AVR Programming](https://cdn-learn.adafruit.com/downloads/pdf/program-an-avr-or-arduino-using-raspberry-pi-gpio-pins.pdf)
[arduino diagram](http://forum.arduino.cc/index.php?topic=84190.0)
[arduino breadboard](https://www.arduino.cc/en/Main/Standalone)
[resistors](https://www.digikey.co.uk/en/resources/conversion-calculators/conversion-calculator-resistor-color-code-4-band)
[atmega circuit](https://www.allaboutcircuits.com/uploads/articles/Arduino_schematic.png)
[bluetooth guide](https://www.sigmdel.ca/michel/ha/rpi/bluetooth_02_en.html#start)
[Atmega328 fust bit guide](https://www.allaboutcircuits.com/projects/atmega328p-fuse-bits-and-an-external-crystal-oscillator/)

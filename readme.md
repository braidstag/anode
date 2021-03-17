## Ansible-stuff

Configurations for the ansible deployment of braidstag. 

We define 3 types of host, a _gun_, a _gateway_, and a _gameserver_.
We aren't using DHCP yet, all devices are assigned ip addresses statically.

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
`ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 192.168.0.151, hostname.yml --extra-vars "ansible_user=pi ansible_password=raspberry" --become`

Meshtag setup
`ansible-playbook -i live.hosts meshtag.yml`

Meshtag setup for a single host
`ansible-playbook -i live.hosts meshtag.yml -l gun1`
`ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i live.hosts meshtag.yml -l meshcontrol -e @andrewVars.yml`

Shutdown all machines
`ansible -i live.hosts all -a "/sbin/shutdown" --become`

Flash all guns (or run any role on any group or host)
`ansible -i live.hosts guns -m include_role -a name=flash`

## Local development
### Setup router
Setup your network such that 192.168.0.0/24 is routable from other machines on your network and 192.168.0.128/25 is not DHCP

Create a file to store some setup specific variables. The most likely to be needed is **external__router** which is the ip of your router and all the gateways will use this for all outbound traffic.
You can use this file by passing `-e @filename` to ansible

As part of development, you will probably want to be able to use commits to the main repo without pushing to github (which means you can `git commit --amend` until you are happy then push.)
All the devices have the same ssh key installed which means if you can grant them all permission to pull from your development machine.

1. Enable access to your machine with the shared key (warning, this is obviously insecure if your machine is ever public!): `cat roles/common/templates/network/id_rsa_meshtag.pub >> ~/.ssh/authorized_keys`
1. add a variable to override the github repo - something like `game_repo: ssh://user@192.168.2.123/home/user/Documents/git/arduino-milestag`
1. You can also specify the branch to pull if you aren't committing to master - `game_version: master`

## Useful links

[AVR Programming](https://cdn-learn.adafruit.com/downloads/pdf/program-an-avr-or-arduino-using-raspberry-pi-gpio-pins.pdf)
[arduino diagram](http://forum.arduino.cc/index.php?topic=84190.0)
[arduino breadboard](https://www.arduino.cc/en/Main/Standalone)
[resistors](https://www.digikey.co.uk/en/resources/conversion-calculators/conversion-calculator-resistor-color-code-4-band)
[atmega circuit](https://www.allaboutcircuits.com/uploads/articles/Arduino_schematic.png)
[bluetooth guide](https://www.sigmdel.ca/michel/ha/rpi/bluetooth_02_en.html#start)
[Atmega328 fust bit guide](https://www.allaboutcircuits.com/projects/atmega328p-fuse-bits-and-an-external-crystal-oscillator/)

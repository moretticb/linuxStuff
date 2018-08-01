#!/bin/bash
#
# instalar extra/openconnect

i3-msg workspace "_"
termite --exec="sudo openconnect vpn.semfio.usp.br" --class="Unused"


#!/bin/bash

clear



#Navigate to file and setup localhost
cd /home/jwohlleber/Schreibtisch/BuZ
node server.js
sleep (3)

#chrome would need changes
google-chrome --kiosk "http://localhost:3000/"


#would also work if chrome makes probs
#chromium-browser --kiosk "http://julianlucas.de/loud/"

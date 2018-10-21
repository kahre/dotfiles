#!/bin/bash

gcalcli --calendar "Träningskalendern" agenda --nocolor | head -2 | tail -1 | sed 's/ \{1,\}/ /g' | sed "s/No Events Found.../No upcoming events/g"

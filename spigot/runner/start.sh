#!/bin/bash
spigot_jar=$(ls spigot-*.jar)

java -Xms1G -Xmx4G -server -jar $spigot_jar nogui
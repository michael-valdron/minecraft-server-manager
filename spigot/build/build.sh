#!/bin/sh
SPIGOT_DIR=/spigot
DATA_DIR=/data
BUILD_FILE=build.jar

cp $SPIGOT_DIR/BuildTool.jar $DATA_DIR/$BUILD_FILE
java -jar $DATA_DIR/$BUILD_FILE
rm $DATA_DIR/$BUILD_FILE

echo "eula=true" > $DATA_DIR/eula.txt
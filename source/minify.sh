#!/bin/bash
declare -a sourcess=();
sources[0]="includes/Core.js"
sources[1]="includes/Unzip.js"
sources[2]="includes/Amiga.js"
sources[3]="includes/Soundblaster.js"
sources[4]="includes/FileLoader.js"
sources[5]="includes/BPPlayer.js"
sources[6]="includes/D1Player.js"
sources[7]="includes/D2Player.js"
sources[8]="includes/DMPlayer.js"
sources[9]="includes/FCPlayer.js"
sources[10]="includes/FXPlayer.js"
sources[11]="includes/HMPlayer.js"
sources[12]="includes/MKPlayer.js"
sources[13]="includes/PTPlayer.js"
sources[14]="includes/S1Player.js"
sources[15]="includes/S2Player.js"
sources[16]="includes/STPlayer.js"
sources[17]="includes/F2Player.js"

tmpfile=/tmp/flood-all-raw.js

echo "" > $tmpfile

for file in ${sources[@]}
do
  echo $file
  cat $file >> $tmpfile
done

curl -s \
  -d compilation_level=SIMPlE_OPTIMIZATIONS \
  -d output_format=text \
  -d output_info=compiled_code \
  --data-urlencode "js_code@${tmpfile}" \
  http://closure-compiler.appspot.com/compile \
  > minified/flod-min.js

#!/bin/bash

DIRECTORY="$(dirname "$0")"

function setup_binary() {
  TEMP_DIR="$(mktemp -d -t fnm)"
  cp ./target/release/fnm "$TEMP_DIR/fnm"
  export PATH=$TEMP_DIR:$PATH
  export FNM_DIR=$TEMP_DIR/.fnm

  # First run of the binary might be slower due to anti-virus software
  echo "Using $(which fnm)"
  echo "  with version $(fnm --version)"
}

setup_binary

RECORDING_PATH=$DIRECTORY/screen_recording

(rm -rf "$RECORDING_PATH" &> /dev/null || true)

docker run --rm -it \
  -v "$PWD:$PWD" \
  -v "$TEMP_DIR:$TEMP_DIR" \
  --workdir "$PWD" \
  -e "PATH_ADDITION=$TEMP_DIR" \
  -e "FNM_DIR=$FNM_DIR" \
  docker.io/asciinema/asciinema \
  rec -c "bash $PWD/$DIRECTORY/recorded_screen_script.sh" "$RECORDING_PATH" --cols 80 --rows 24

sed "s@$TEMP_DIR@~@g" "$RECORDING_PATH" \
  | pnpm svg-term --window --out "$DIRECTORY/fnm.svg" --height=17 --width=70

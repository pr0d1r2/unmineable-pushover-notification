#!/usr/bin/env bash

set -e -x

WORKERS_OFFLINE=()

test -d /usr/local/share/unmineable-workers || git clone https://github.com/pr0d1r2/unmineable-workers /usr/local/share/unmineable-workers
cd /usr/local/share/unmineable-workers
git pull
bundle install

for ACCOUNT_DETAILS in "$(cat /etc/unmineable-accounts)"
do
  ACCOUNT="$(echo "$ACCOUNT_DETAILS" | cut -f 1 -d :)"
  EXPECTED_HOSTS="$(echo "$ACCOUNT_DETAILS" | cut -f 2 -d : | tr "," " ")"

  echo "$ACCOUNT" > .account

  for OFFLINE_WORKER in $(bundle exec bin/all_offline $EXPECTED_HOSTS)
  do
    WORKERS_OFFLINE_FIRST+=("$OFFLINE_WORKER")
  done

  for OFFLINE_WORKER in $(bundle exec bin/all_offline $WORKERS_OFFLINE_FIRST)
  do
    WORKERS_OFFLINE+=("$OFFLINE_WORKER")
  done
done

case "$WORKERS_OFFLINE" in
  "")
    echo "OK: all workers online"
    exit 0
    ;;
esac

MESSAGE="Workers offline: $WORKERS_OFFLINE"

for DEVICE_CREDENTIALS in $(cat /etc/unmineable-pushover-devices)
do
  USER="$(echo "$DEVICE_CREDENTIALS" | cut -f 1 -d :)"
  TOKEN="$(echo "$DEVICE_CREDENTIALS" | cut -f 2 -d :)"
  curl -s --form-string "token=$TOKEN" --form-string "user=$USER" --form-string "message=$MESSAGE" "https://api.pushover.net/1/messages.json"
done

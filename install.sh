#!/usr/bin/env bash

set -e -x

cd "$(dirname "$0")"

PROJECT="$(pwd -P)"

command -v parallel || apt-get -y -q install parallel

find "$PROJECT/commands" -type f -name "*.sh" | parallel "cp {} /usr/local/bin/{/.} && chmod 755 /usr/local/bin/{/.}"
find "$PROJECT/systemd" -type f -name "*.service" | parallel "cp {} /etc/systemd/system/{/}"

touch /etc/unmineable-accounts
touch /etc/unmineable-pushover-devices

echo "Add your unmineable accounts with expected workers to: /etc/unmineable-accounts"
echo "Add your pushover devices to: /etc/unmineable-pushover-devices"

#!/usr/bin/env bash

HAL_USER=$(cat /home/duftler/hal/spinnaker/config/halyard-user)

if [ -z "$HAL_USER" ]; then
  echo >&2 "Unable to derive halyard user, likely a corrupted install. Aborting."
  exit 1
fi

sudo groupadd halyard || true
sudo groupadd spinnaker || true
sudo usermod -G halyard -a $HAL_USER || true
sudo usermod -G spinnaker -a $HAL_USER || true

sudo mkdir -p /var/log/spinnaker/halyard
sudo chown $HAL_USER:halyard /var/log/spinnaker/halyard
sudo chmod 755 /var/log/spinnaker /var/log/spinnaker/halyard

sudo ~/hal/update-halyard $@

retVal=$?
if [ $retVal == 13 ]; then
  exit 13
fi

mkdir -p ~/hal/log
sudo mv /usr/local/bin/hal ~/hal
sudo mv /opt/halyard ~/hal
sudo mv /usr/local/bin/update-halyard ~/hal

sed -i 's:^. /etc/bash_completion.d/hal:# . /etc/bash_completion.d/hal\n. ~/hal/hal_completion\nalias hal=~/hal/hal:' ~/.bashrc
sed -i s:/opt/halyard:~/hal/halyard:g ~/hal/hal
sed -i s:/var/log/spinnaker/halyard:~/hal/log:g ~/hal/hal
sudo sed -i s:/opt/spinnaker:~/hal/spinnaker:g ~/hal/halyard/bin/halyard
sed -i 's:rm -rf /opt/halyard:rm -rf /home/duftler/hal/halyard:g' ~/hal/update-halyard
sed -i s:/opt/spinnaker:/home/duftler/hal/spinnaker:g ~/hal/update-halyard
sed -i s:/etc/bash_completion.d/hal:/home/duftler/hal/hal_completion: ~/hal/update-halyard

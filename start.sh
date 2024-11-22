#!/bin/bash
checkASN () {
  local retrieveASN=$1
  retrieveASN=$(echo "$retrieveASN" | xargs)
  if [ -z "$retrieveASN" ]; then
    echo "The ASN number is not specified."
    return 1
  fi
  if ! [[ "$retrieveASN" =~ ^[0-9]+$ ]]; then
    echo "Invalid ASN number."
    return 1
  fi
  if [ "$retrieveASN" -lt 1 ] || [ "$retrieveASN" -gt 4294967295 ]; then
    echo "Invalid ASN number."
    return 1
  fi
  if ([ "$retrieveASN" -ge 0 ] && [ "$retrieveASN" -le 1023 ]) || 
     [ "$retrieveASN" -eq 23456 ] || 
     ([ "$retrieveASN" -ge 64512 ] && [ "$retrieveASN" -le 65535 ]) || 
     ([ "$retrieveASN" -ge 4200000000 ] && [ "$retrieveASN" -le 4294967295 ]); then
    echo "Bogon ASN detected."
    return 1
  fi
  return 0
}


if [ ! -f /etc/bgpalerter/bgpalerter ]; then
  echo "Cannot find bgpalerter, downloading..."
  wget https://github.com/nttgin/BGPalerter/releases/latest/download/bgpalerter-linux-x64 -O /etc/bgpalerter/bgpalerter
  chmod a+x /etc/bgpalerter/bgpalerter
else
  echo "bgpalerter found. Skip downloading."
fi
if [ ! -f /etc/bgpalerter/config.yml ]; then
  echo "Cannot find config.yml, downloading default config..."
  wget https://raw.githubusercontent.com/nttgin/BGPalerter/main/config.yml.example -O /etc/bgpalerter/config.yml
else
  echo "config.yml found. Skip downloading."
fi

checkASN "$ASN"
checkASNNum=$?

if [ $checkASNNum -eq 1 ]; then
  exit 1
else
  echo "Valid ASN $ASN detected, generating prefix list..."
  cd /etc/bgpalerter
  /etc/bgpalerter/bgpalerter generate -a $ASN -o prefixes.yml -i -m
fi

echo "All good for now. Starting bgpalerter..."
cd /etc/bgpalerter
/etc/bgpalerter/bgpalerter

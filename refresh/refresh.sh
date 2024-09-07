#!/bin/bash
read -p "Choose a port: " port

function open {
  if [ $(find * -name "index."*) ]; then
    python3 -m http.server "$port" &
    server_pid=$!
    sleep 1
    firefox --new-window "http://localhost:$port" &
    browser_pid=$!
    sleep 2  # Give some time for the browser to open
    ff_clear_cache
    init_check
    hash_check
  else
    echo "No index detected. Please create one and try again."
  fi
}

function ff_clear_cache {
  title_tag=$(find * -name "index.*" | awk '{print "grep -m 1 title "$0}' | $SHELL | awk -F "[</>]" '{print $3}')
  clear_cache="ctrl+shift+r"
  xdotool search --name "$title_tag" key "$clear_cache"
}

function init_check {
  mkdir -p /tmp/refresh/
  find . -type f ! -name "*.swp" ! -path "./.git/*" | awk '{print "cat "$0}' | $SHELL  > /tmp/refresh/contents
  md5sum /tmp/refresh/contents > /tmp/refresh/digest
}

function hash_check {
  while true; do 
    #sleep 1  # Add a delay between checks to prevent high CPU usage

    find .  -type f ! -name "*.swp" ! -path "./.git/*" | awk '{print "cat "$0}' | $SHELL > /tmp/refresh/contents 
    new_hash=$(md5sum /tmp/refresh/contents)
    old_hash=$(cat /tmp/refresh/digest)

    if [ "$new_hash" != "$old_hash" ]; then 
      ff_clear_cache
      init_check  
    fi
  done
}

open


read -p "Choose a port: " port

function open {
  if ls "index."* &> /dev/null; then
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
  title_tag=$(grep -m 1 -i '<title>' ./index.* | awk -F '[</>]' '{print $3}')
  clear_cache="ctrl+shift+r"
  xdotool search --name "$title_tag" key "$clear_cache"
}

function init_check {
  mkdir -p $PREFIX/tmp/refresh/
  ls -lahR > $PREFIX/tmp/refresh/contents
  md5sum $PREFIX/tmp/refresh/contents > $PREFIX/tmp/refresh/digest
}

function hash_check {
  while true; do 
    sleep 1  # Add a delay between checks to prevent high CPU usage
    ls -lahR > $PREFIX/tmp/refresh/contents 
    new_hash=$(md5sum $PREFIX/tmp/refresh/contents)
    old_hash=$(cat $PREFIX/tmp/refresh/digest)

    if [ "$new_hash" != "$old_hash" ]; then 
      ff_clear_cache
      init_check  
    fi
  done
}

open


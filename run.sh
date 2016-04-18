#!/usr/bin/zsh

source /home/memilian/.zshaliases
khamake html5 --server &
LAST=`ls -l Sources/**/*`
BROWSER=chromium
RELOAD_KEYS="CTRL+R"
RELOAD_KEYS="SHIFT+CTRL+R"

while true; do

  sleep 1
    NEW=`ls -l Sources/**/*`
  if [ "$NEW" != "$LAST" ]; then
    khamake html5
    LAST="$NEW"
  fi
done

#chromium "http://localhost:8080"

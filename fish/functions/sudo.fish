function sudo
  echo "[sudo] Are you sure you want to sudo $argv"
  read confirm
  if [ x$confirm = xy ] || [ x$confirm = xY ]
    echo "[sudo] Running sudo $argv"
    /bin/sudo $argv
  else
    echo "[sudo] Better think twice!"
  end
end

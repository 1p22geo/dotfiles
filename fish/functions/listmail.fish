function listmail
  set -l files (/sbin/ls /home/bartoszg/Mail/INBOX/new/)
  if [ -z "$files" ]
    echo "No new mail"
    return
  end
  echo "New mail: "
  for f in /home/bartoszg/Mail/INBOX/new/*
    cat $f | grep "From: "
  end

end

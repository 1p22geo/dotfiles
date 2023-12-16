function _tide_item_mail
  set mail $(countmail)
  if [ "$mail" = "0" ]
    return
  end
  if [ "$mail" = "" ]
    return
  end
  _tide_print_item mail $tide_mail_icon' ' (countmail)

end

function cpass
  # copy a password into clipboard
  pass $1  | read text ; copyq copy $text
end

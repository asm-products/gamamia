var truncate = function truncate(string, length) {
  return string.substring(0, length) + '…'
}

window.truncate = truncate

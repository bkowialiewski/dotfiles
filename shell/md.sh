function md() {
  pandoc $1 > /tmp/$1.html
  xdg-open /tmp/$1.html
}

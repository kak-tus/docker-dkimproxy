max_stale = "2m"

template {
  source = "/root/templates/dkimproxy.map.template"
  destination = "/etc/dkimproxy.map"
}

exec {
  command = "/usr/local/bin/start.sh"
  splay = "60s"
}

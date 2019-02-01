max_stale = "2m"

template {
  source = "/root/templates/dkimproxy.map.template"
  destination = "/etc/dkimproxy.map"
}

template {
  source = "/root/templates/start.sh.template"
  destination = "/usr/local/bin/start.sh"
  perms = 0755
}

exec {
  command = "/usr/local/bin/start.sh"
  splay = "60s"
}

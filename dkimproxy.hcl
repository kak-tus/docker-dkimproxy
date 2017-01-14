max_stale = "2m"

template {
  source = "/root/start_dkimproxy.sh.template"
  destination = "/usr/local/bin/start_dkimproxy.sh"
  perms = 0755
}

exec {
  command = "/usr/local/bin/start_dkimproxy.sh"
  splay = "60s"
}

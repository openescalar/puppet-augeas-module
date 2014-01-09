(*
Author: Miguel Zuniga miguel-zuniga at hotmail.com
vim: ts=2 sw=2 expandtab
*)
module Test_nsswitch =
  let conf ="# /etc/nsswitch.conf
# Other comment
passwd:     files

hosts:      files dns
bootparams: nisplus [NOTFOUND=return] files
"

  test Nsswitch.lns get conf =
    { "#comment" = "/etc/nsswitch.conf" } 
    { "#comment" = "Other comment" }
    { "passwd"
      { "lookup" = "files" }
    }
    {}
    { "hosts"
      { "lookup" = "files" }
      { "lookup" = "dns" }
    }
    { "bootparams"
      { "lookup" = "nisplus" }
      { "lookup" = "[NOTFOUND=return]" }
      { "lookup" = "files" }
    }

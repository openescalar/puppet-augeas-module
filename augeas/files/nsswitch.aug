(* nsswitch.conf module for Augeas

Based on documentation from `man 5 /etc/nsswitch.conf'

vim: ts=2 sw=2 expandtab
*)

module Nsswitch =
  autoload xfm

  let eol = Util.eol
  let comment = Util.comment
  let empty = Util.empty
  let colon = Sep.colon
  let spc   = Util.del_ws_spc
  let value_to_spc = store /[^ \t\n]+/

  let service = [ label "lookup" . counter "lookup" . spc . value_to_spc  ]

  let db = [ key /[A-Za-z]+/ . colon . ( service )+ . eol ]

  let databases = db

(*  let db_line (db:string) = [ key db . colon . ( service )+ . eol ] *)

(*
  let databases = db_line "aliases"
                | db_line "ethers"
                | db_line "passwd"
                | db_line "shadow"
                | db_line "group"
                | db_line "hosts"
                | db_line "netgroup"
                | db_line "networks"
                | db_line "protocols"
                | db_line "publickey"
                | db_line "rpc"
                | db_line "services"
                | db_line "bootparams" 
                | db_line "netmasks"
                | db_line "automount"
*)

  let lns = (comment|empty|databases) *

  let filter = incl "/etc/nsswitch.conf"
             . Util.stdexcl

  let xfm = transform lns filter


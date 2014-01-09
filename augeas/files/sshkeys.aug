(* 
vim: ts=2 sw=2 expandtab
*)

module Sshkeys =
  autoload xfm

  let eol = Util.eol
  let comment = Util.comment
  let empty = Util.empty
  let colon = Sep.colon
  let spc   = Util.del_ws_spc
  let value_to_spc = store /[^ \t\n]+/

  let keyvalue = [ label "keyv" . counter "keyv" . spc . value_to_spc  ]

  let dsakey = [ key /ssh\-dsa/ . ( keyvalue )+ . eol ]
  let dsskey = [ key /ssh\-dss/ . ( keyvalue )+ . eol ]
  let rsakey = [ key /ssh\-rsa/ . ( keyvalue )+ . eol ]
  let rsa1key = [ key /1024/ . ( keyvalue )+ . eol ]

  let lns = (comment|empty|dsakey|rsakey|rsa1key|dsskey) *

  let filter = incl "/root/.ssh/authorized_keys"
             . Util.stdexcl

  let xfm = transform lns filter


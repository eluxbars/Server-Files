
description "vRP MySQL async - Modified Version"
dependency "ghmattimysql"
-- server scripts
server_scripts{ 
  "@VRP/lib/utils.lua",
  "MySQL.lua"
}


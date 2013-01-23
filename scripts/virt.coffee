# Create, destroy, and manage virtual machines
#
# virt create <name>
# virt shutdown <machine>
# virt destroy <machine>
# virt list
# virt status <machine>
#
'koan --virt --port=80 --server=192.168.226.90 --profile=kvm-test --virt-path=/dev/kvmvg/kvm-test --virt-name=kvm-test'
module.export = (robot) ->
  robot.respond /virt create (.*)$/i, (msg) ->
    

run = (cmd, cb) ->
  sys = require 'util'
  exec = require('child_process').exec
  exec(cmd, cb)

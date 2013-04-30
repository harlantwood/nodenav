{exec} = require 'child_process'
COMPILE_CMD = '--compile ./'

task 'build', 'Compile CoffeeScript', ->
  exec "coffee #{COMPILE_CMD}", (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

task 'watch', 'Watch for changes, and recompile CoffeeScript', ->
  exec "coffee --watch #{COMPILE_CMD}", (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr


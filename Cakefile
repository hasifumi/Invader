sys = require 'sys'
exec = (require 'child_process').exec

FILENAME = 'game'
FILES = [
  'coffee/game.coffee',
  'coffee/dummy.coffee',
  'coffee/fighter.coffee',
  'coffee/beam.coffee',
]
HTMLFILE = 'index.html'

task 'compile', 'compile Invader', (options) ->
  outputErr = (err, stdout, stderr) ->
    throw err if err
    if stdout or stderr
      console.log "#{stdout} #{stderr}"
  if FILES.length is 1
    exec "coffee -c #{FILENAME}.js #{FILES[0]}", outputErr
  else
    exec "coffee -cj #{FILENAME} #{FILES.join ' '}", outputErr 

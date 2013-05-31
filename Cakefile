util = require('util')
exec = require('child_process').exec

task 'build', 'Builds CoffeeScript files into JavaScript files', (options)->
  util.log('Start build...')
  exec 'coffee -c -o ./script ./coffee', (error, stdout, stderr)->
    if error
      util.log('Build fail : '+error)
    else
      util.log('Build success')

task 'build-css', 'Builds SCSS files into CSS files', (options)->
  util.log('Start build...')
  exec 'scss scss/main.scss css/main.css -t expanded', (error, stdout, stderr)->
    if error
      util.log('Build fail : '+error)
    else
      util.log('Build success')

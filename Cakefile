util = require('util')
exec = require('child_process').exec

task 'build', 'Builds CoffeeScript files into JavaScript files', (options)->
  util.log('Start build...')
  exec 'coffee -c -o ./script ./script/coffee', (error, stdout, stderr)->
    if error
      util.log('Build fail')
    else
      util.log('Build success')

task 'build-css', 'Builds SCSS files into CSS files', (options)->
  util.log('Start build...')
  exec 'scss style/scss/main.scss style/main.css', (error, stdout, stderr)->
    if error
      util.log('Build fail')
    else
      util.log('Build success')

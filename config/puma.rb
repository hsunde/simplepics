require 'fileutils'
FileUtils.mkdir_p 'tmp'
FileUtils.mkdir_p 'content'
FileUtils.mkdir_p 'db'
FileUtils.mkdir_p 'thumbs'

root = "#{Dir.getwd}"

# bind "unix://#{root}/tmp/puma/socket"
pidfile "#{root}/tmp/pid"
state_path "#{root}/tmp/state"
rackup "#{root}/config/config.ru"

# port 9191
bind "tcp://0.0.0.0:9191"

threads 2, 4

#stdout_redirect "#{root}/log/puma.stdout.log", "#{root}/log/puma.stderr.log", true

#activate_control_app "unix://#{root}/tmp/puma/control.socket"

# coding: utf-8

namespace :unicorn do
  task :start do
    config = Rails.root.join('config', 'unicorn.rb')
    command = "bundle exec unicorn_rails -c #{config} -E development -D"
    puts command
    puts `#{command}`
  end

  task :stop do
    command = 'cat /tmp/unicorn.pid  | xargs kill -9'
    puts command
    puts `#{command}`
  end
end

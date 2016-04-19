# coding: utf-8

worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
timeout 15
preload_app true # 更新時ダウンタイム無し

listen '/tmp/unicorn.sock'
pid '/tmp/unicorn.pid'

before_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_fork do |_server, _worker|
  Signal.trap 'TERM' do
    # rubocop:disable Style/LineLength
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
    # rubocop:enable Style/LineLength
  end

  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end

# ログの出力
stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
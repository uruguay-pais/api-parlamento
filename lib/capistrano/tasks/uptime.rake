desc 'Look at uptime on the server'
role :demo, %w{datauy.org}
task :uptime do |host|
  on roles(:demo), in: :parallel do
    uptime = capture(:uptime)
    puts "#{host.hostname} reports: #{uptime}"
  end
end

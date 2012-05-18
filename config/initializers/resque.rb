require 'resque'
require 'resque_scheduler'
require 'resque/scheduler'
require 'resque_scheduler/server'

Dir["#{Rails.root}/app/workers/*.rb"].each { |file| require file }

Resque.schedule = YAML.load_file("#{Rails.root}/config/schedule.yml")
Resque.redis = 'localhost:6379'

Resque::Server.use(Rack::Auth::Basic) do |user, password|
  password == "1816151620"
end

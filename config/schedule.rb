# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/home/deployer/cron_log.log"
#
every 2.minutes do
  runner "DepartureDate.new_day_in_day_of_life"
  runner "DepartureDate.destroy_today_from_day_of_life"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

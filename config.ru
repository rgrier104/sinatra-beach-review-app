require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#in order to send PATCH and DELETE requests
use Rack::MethodOverride
# mount other controllers with use
use BeachesController
use ReviewsController
use UsersController
run ApplicationController

require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

# remove this to see the sql queries in the return value
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

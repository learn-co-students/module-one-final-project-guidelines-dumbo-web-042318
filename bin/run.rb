#!/usr/bin/env ruby

require_relative '../config/environment'
# require 'pry'

###do i need to require 'lib', if it's already required in config/environment which is required above?
require_all 'lib'

four_twenty_tripster_cli_interface
# binding.pry
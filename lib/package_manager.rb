require 'rubygems' if RUBY_VERSION < '1.9'
require 'package_manager/base'
require 'package_manager/apt'
require 'package_manager/dpkg'
require 'package_manager/fink'
require 'package_manager/port'
require 'package_manager/rpm'
require 'package_manager/yum'

module PackageManager

  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 0
    TINY  = 2
 
    STRING = [ MAJOR, MINOR, TINY ].join('.')
  end

end

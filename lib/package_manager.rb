require 'rubygems' if RUBY_VERSION < '1.9'
require 'package_manager/base'

module PackageManager

  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 0
    TINY  = 4
 
    STRING = [ MAJOR, MINOR, TINY ].join('.')
  end

end

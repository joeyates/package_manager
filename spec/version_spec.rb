require 'rubygems' if RUBY_VERSION < '1.9'
require 'spec'

SPEC_PATH = File.expand_path( File.dirname( __FILE__ ) )
ROOT_PATH = File.dirname( SPEC_PATH )
require File.join( ROOT_PATH, 'lib', 'package_manager' )

describe 'the package' do

  it 'has a VERSION' do
    PackageManager::VERSION::MAJOR.should_not  be_nil
    PackageManager::VERSION::MINOR.should_not  be_nil
    PackageManager::VERSION::TINY.should_not   be_nil
    PackageManager::VERSION::STRING.should_not be_nil
  end

end

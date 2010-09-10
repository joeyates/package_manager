require 'rubygems' if RUBY_VERSION < '1.9'
require 'spec'

SPEC_PATH = File.expand_path( File.dirname( __FILE__ ) )
ROOT_PATH = File.dirname( SPEC_PATH )
require File.join( ROOT_PATH, 'lib', 'package_manager' )

describe 'subclasses' do

  it "PackageManager::Apt#name should return 'apt'" do
    PackageManager::Apt.new.name.should == 'apt'
  end

  it "PackageManager::Dpkg#name should return 'dpkg'" do
    PackageManager::Dpkg.new.name.should == 'dpkg'
  end

  it "PackageManager::Fink#name should return 'fink'" do
    PackageManager::Fink.new.name.should == 'fink'
  end

  it "PackageManager::Port#name should return 'port'" do
    PackageManager::Port.new.name.should == 'port'
  end

  it "PackageManager::Rpm#name should return 'rpm'" do
    PackageManager::Rpm.new.name.should == 'rpm'
  end

  it "PackageManager::Yum#name should return 'yum'" do
    PackageManager::Yum.new.name.should == 'yum'
  end

end

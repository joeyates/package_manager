require 'rubygems' if RUBY_VERSION < '1.9'
require 'spec'

SPEC_PATH = File.expand_path( File.dirname( __FILE__ ) )
ROOT_PATH = File.dirname( SPEC_PATH )
require File.join( ROOT_PATH, 'lib', 'package_manager' )

describe 'operating system sensing' do

  it "should throw an error if Gem.platforms doesn't return an Array" do
    Gem.stub!( :platforms ).and_return( nil )
    lambda do
      pkg = PackageManager::Base.load
    end.should raise_error( StandardError, /Unexpected.*?response/ )
  end

  it "should throw an error if Gem.platforms doesn't return two values" do
    Gem.stub!( :platforms ).and_return( [] )
    lambda do
      pkg = PackageManager::Base.load
    end.should raise_error( StandardError, /Expected.*?Array.*?2/ )
  end

  it "should throw an error if Gem.platforms doesn't return two values" do
    Gem.stub!( :platforms ).and_return( [] )
    lambda do
      pkg = PackageManager::Base.load
    end.should raise_error( StandardError, /Expected.*?Array.*?2/ )
  end

  it "should throw an error if Gem.platforms doesn't return an Object which yields an os" do
    Gem.stub!( :platforms ).and_return( [ nil, nil ] )
    lambda do
      pkg = PackageManager::Base.load
    end.should raise_error( StandardError, /Unexpected operating system object/ )
  end

  it "should use the os value returned by Gem.platforms" do
    operating_system = stub( 'thing', :os => 'my os' )
    Gem.stub!( :platforms ).and_return( [ nil, operating_system ] )
    lambda do
      pkg = PackageManager::Base.load
    end.should raise_error( StandardError, /my os/ )
  end

  it 'should throw an error on unknown operating systems' do
    PackageManager::Base.stub!( :operating_system ).and_return( 'foo' )
    lambda do
      pkg = PackageManager::Base.load
    end.should raise_error( StandardError, /Unhandled+.*?operating.*?system/ )
  end

end

describe 'system interactions' do

  it 'should use shell calls to determine what is installed' do
    PackageManager::Base.stub!( :operating_system ).and_return( 'linux' )
    `ls` # Force $? is 0
    PackageManager::Base.should_receive( '`'.intern ).with( "which 'apt-get'" ).and_return( '/path/to/apt-get' )
    pkg = PackageManager::Base.load
    pkg.name.should == 'apt'
  end

end

describe 'Linux package manager guessing' do

  before( :each ) do
    PackageManager::Base.stub!( :operating_system ).and_return( 'linux' )
  end

  it 'should always return a PackageManager::Base subclass' do
    PackageManager::Base.stub!( :program_installed? ).with( 'apt-get' ).and_return( true )
    pkg = PackageManager::Base.load
    pkg.should_not be_nil
  end

  it 'with apt-get available, should return a PackageManager::Apt' do
    PackageManager::Base.stub!( :program_installed? ).with( 'apt-get' ).and_return( true )
    pkg = PackageManager::Base.load
    pkg.class.should == PackageManager::Apt
  end

  it 'with yum available, should return a PackageManager::Yum' do
    PackageManager::Base.stub!( :program_installed? ).with( 'apt-get' ).and_return( false )
    PackageManager::Base.stub!( :program_installed? ).with( 'yum' ).and_return( true )
    pkg = PackageManager::Base.load
    pkg.class.should == PackageManager::Yum
  end

  it 'with rpm available, should return a PackageManager::Rpm' do
    PackageManager::Base.stub!( :program_installed? ).with( 'apt-get' ).and_return( false )
    PackageManager::Base.stub!( :program_installed? ).with( 'yum' ).and_return( false )
    PackageManager::Base.stub!( :program_installed? ).with( 'rpm' ).and_return( true )
    pkg = PackageManager::Base.load
    pkg.class.should == PackageManager::Rpm
  end

  it 'with no known package manager available, should raise an error' do
    PackageManager::Base.stub!( :program_installed? ).with( 'apt-get' ).and_return( false )
    PackageManager::Base.stub!( :program_installed? ).with( 'yum' ).and_return( false )
    PackageManager::Base.stub!( :program_installed? ).with( 'rpm' ).and_return( false )
    lambda do
      pkg = PackageManager::Base.load
    end.should raise_error( StandardError, /Unknown+.*?package.*?manager/ )
  end

end

describe 'OS X package manager guessing' do

  before( :each ) do
    PackageManager::Base.stub!( :operating_system ).and_return( 'darwin' )
  end

  it 'should return a PackageManager::Base subclass' do
    PackageManager::Base.stub!( :program_installed? ).with( 'port' ).and_return( true )
    pkg = PackageManager::Base.load
    pkg.should_not be_nil
  end

  it 'with port available, should return a PackageManager::Port' do
    PackageManager::Base.stub!( :program_installed? ).with( 'port' ).and_return( true )
    pkg = PackageManager::Base.load
    pkg.class.should == PackageManager::Port
  end

  it 'with port available, should return a PackageManager::Fink' do
    PackageManager::Base.stub!( :program_installed? ).with( 'port' ).and_return( false )
    PackageManager::Base.stub!( :program_installed? ).with( 'apt-get' ).and_return( true )
    pkg = PackageManager::Base.load
    pkg.class.should == PackageManager::Fink
  end

  it 'with no known package manager available, should raise an error' do
    PackageManager::Base.stub!( :program_installed? ).with( 'port' ).and_return( false )
    PackageManager::Base.stub!( :program_installed? ).with( 'apt-get' ).and_return( false )
    lambda do
      pkg = PackageManager::Base.load
    end.should raise_error( StandardError, /Unknown+.*?package.*?manager/ )
  end

end

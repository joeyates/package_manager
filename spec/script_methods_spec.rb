require 'rubygems' if RUBY_VERSION < '1.9'
require 'spec'

SPEC_PATH = File.expand_path( File.dirname( __FILE__ ) )
ROOT_PATH = File.dirname( SPEC_PATH )
require File.join( ROOT_PATH, 'lib', 'package_manager' )

describe 'script methods' do
  
  before( :all ) do
    PackageManager::Base.stub!( :operating_system ).and_return( 'linux' )
    PackageManager::Base.stub!( :program_installed? ).with( 'apt-get' ).and_return( true )
    @pkg = PackageManager::Base.load
  end

  it "should run commands through a subprocess" do
    @pkg.should_receive( '`'.intern ).and_return( "foo\n" )
    @pkg.find_available( 'pkg' )
  end

  it "#find_available should return an Array of matching packages" do
    @pkg.stub!( :run_command ).and_return( "pkg1\npkg2" )
    @pkg.find_available( 'pkg' ).should be_a( Array )
  end

  it "#find_installed should return an Array of matching packages" do
    @pkg.stub!( :run_command ).and_return( "pkg1\npkg2" )
    @pkg.find_installed( 'pkg' ).should be_a( Array )
  end

  it "#list_contents should return an Array of files" do
    @pkg.stub!( :run_command ).and_return( "/path/to/file1\n/path/to/file2" )
    @pkg.list_contents( 'pkg' ).should be_a( Array )
  end

  it "#install should return true or false" do
    `ls`
    @pkg.stub!( :run_command )
    @pkg.install( 'pkg' ).should be_true
  end

  it "#install_file should return true or false" do
    `ls` # Force $?.exitstatus to be 0
    @pkg.stub!( :run_command )
    File.stub!( :exist? ).and_return( true )
    @pkg.install_file( 'my_pkg' ).should be_true
  end

  it "#install_file should throw an error if the file does not exist" do
    @pkg.stub!( :run_command )
    File.stub!( :exist? ).and_return( false )
    lambda do
      @pkg.install_file( 'my_pkg' )
    end.should raise_error( StandardError, /does not exist/ )
  end

  it "#uninstall should return true or false" do
    `ls`
    @pkg.stub!( :run_command )
    @pkg.uninstall( 'pkg' ).should be_true
  end

  it "#provides should return a String" do
    @pkg.stub!( :run_command ).and_return( 'my_pkg' )
    File.stub!( :exist? ).and_return( true )
    @pkg.provides( '/file/from/package' ).should == 'my_pkg'
  end

  it "#provides should throw an error if the file does not exist" do
    @pkg.stub!( :run_command ).and_return( 'my_pkg' )
    File.stub!( :exist? ).and_return( false )
    lambda do
      @pkg.provides( '/file/from/package' )
    end.should raise_error( StandardError, /does not exist/ )
  end

end

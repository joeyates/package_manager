require 'rubygems'

# Pre-declare Base class, so we can load derived classes for class factory
module PackageManager
  class Base; end
end

require 'package_manager/apt'
require 'package_manager/dpkg'
require 'package_manager/fink'
require 'package_manager/port'
require 'package_manager/rpm'
require 'package_manager/yum'

module PackageManager

  class Base

    attr_reader :name

    KNOWN_PACKAGE_MANAGERS = { 'apt'  => Apt,
                               'dpkg' => Dpkg,
                               'fink' => Fink,
                               'port' => Port,
                               'rpm'  => Rpm,
                               'yum'  => Yum }

    def self.load( package_manager = guess_package_manager )
      raise 'Unknown package manager' if KNOWN_PACKAGE_MANAGERS[ package_manager ].nil?
      KNOWN_PACKAGE_MANAGERS[ package_manager ].new
    end

    # Returns an array of matches
    def find_available( package_match )
      run_command( find_available_command, package_match ).split("\n")
    end

    # Returns an array of matches
    def find_installed( package_match )
      run_command( find_installed_command, package_match ).split("\n").uniq
    end

    # Returns an array of file names
    def list_contents( package )
      run_command( list_contents_command, package ).split("\n")
    end

    # Returns true if the package installed successfully
    def install( package )
      run_command( install_command, package )
      $?.exitstatus == 0
    end

    # Returns true if the package installed successfully
    def install_file( file )
      raise 'The file '#{ file }' does not exist' if ! File.exist?( file )
      run_command( install_file_command, file )
      $?.exitstatus == 0
    end

    # Returns true if the package uninstalled successfully
    def uninstall( package )
      run_command( uninstall_command, package )
      $?.exitstatus == 0
    end

    # Returns the package name if found, or an empty string
    def provides( file )
      raise 'The file '#{ file }' does not exist' if ! File.exist?( file )
      run_command( provides_command, file )
    end

    private

    def run_command( command, *args )
      `#{ command } #{ args.join( ' ' ) }`.chomp
    end

    def self.guess_package_manager
      case operating_system
      when 'linux'
        linux_package_manager
      when 'darwin'
        darwin_package_manager
      else
        raise 'Unhandled operating system'
      end
    end

    def self.operating_system
      platforms = Gem.platforms
      raise 'Unexpected response from Gem.platforms'     unless platforms.respond_to?( :size )
      raise 'Expected Array of 2 values'                 unless platforms.size == 2
      raise 'Unexpected value returned by Gem.platforms' unless platforms[ 1 ].respond_to?( :os )
      platforms[ 1 ].os
    end

    def self.linux_package_manager
      case
      when program_installed?( 'apt-get' )
        'apt'
      when program_installed?( 'yum' )
        'yum'
      when program_installed?( 'rpm' )
        'rpm'
      else
        raise "Unknown or missing package manager system"
      end
    end

    # TODO: Add brew
    def self.darwin_package_manager
      # Be opinionated and prefer Mac Ports if both it and Fink are installed
      case
      when program_installed?( 'port' )
        'port'
      when program_installed?( 'apt-get' )
        'fink'
      else
        raise "Unknown or missing package manager system"
      end
    end

    def self.program_installed?( program )
      `which '#{ program }'`
      $?.exitstatus == 0
    end

  end

end

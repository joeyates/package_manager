module PackageManager

  class Base

    attr_reader :name

    def self.load
      PackageManager::Port.new
    end

    def find_available( argv )
      raise "You should supply a search pattern" if argv.size < 1
      command = find_available_command
      run_command( command, argv[ 0 ] )
    end

    def find_installed( argv )
      raise "You should supply a search pattern" if argv.size < 1
      command = find_installed_command
      run_command( command, argv[ 0 ] )
    end

    def list_contents( argv )
      raise "You should supply a package name" if argv.size < 1
      command = list_contents_command
      run_command( command, argv[ 0 ] )
    end

    def install( argv )
      raise "You should supply a package name" if argv.size < 1
      command = install_command
      run_command( command, argv[ 0 ] )
    end

    def install_file( argv )
      raise 'No package name supplied'                 if argv.size < 1
      raise 'The file '#{ ARGV[ 0 ] }' does not exist' if ! File.exist?( argv[ 0 ] )
      run_command( install_file_command, argv[ 0 ] )
    end

    def uninstall( argv )
      raise "You should supply a package name" if argv.size < 1
      run_command( uninstall_command, argv[ 0 ] )
    end

    def provides( argv )
      raise 'No package name supplied'                 if argv.size < 1
      raise 'The file '#{ ARGV[ 0 ] }' does not exist' if ! File.exist?( argv[ 0 ] )
      run_command( provides_command, argv[ 0 ] )
    end

    private

    def run_command( command, *args )
      `#{ command } #{ args.join( ' ' ) }`
    end

  end

end

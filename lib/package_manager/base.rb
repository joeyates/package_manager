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

    def run_command( command, *args )
      `#{ command } #{ args.join( ' ' ) }`
    end

  end

end

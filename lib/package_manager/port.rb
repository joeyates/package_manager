module PackageManager

  class Port < ::PackageManager::Base

    def initialize
      @name = 'port'
    end

    private

    def find_available_command
      'port search'
    end

    def find_installed_command
      # list all      | grab first word               | grep
      "port installed | sed -E -e 's/ +([^ ]+).*/\\1/' | grep "
    end

    def install_command
      'port install'
    end

    def uninstall_command
      'port uninstall'
    end

    def provides_command
      'port provides'
    end

    def list_contents_command
      'port contents'
    end

  end

end

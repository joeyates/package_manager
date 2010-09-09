module PackageManager

  class Apt < Dpkg

    def initialize
      @name = 'apt'
    end

    private

    def find_available_command
      'apt-cache search'
    end

    def find_installed_command
      'apt-cache search --installed --names-only'
    end

    def install_command
      'apt-get install'
    end

    def uninstall_command
      'apt-get remove'
    end

  end

end

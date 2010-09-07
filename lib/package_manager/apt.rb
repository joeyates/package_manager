module PackageManager

  class Apt < ::PackageManager::Base

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

  end

end

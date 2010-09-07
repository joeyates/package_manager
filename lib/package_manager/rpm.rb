module PackageManager

  class Rpm < ::PackageManager::Base

    def initialize
      @name = 'rpm'
    end

    private

    def find_installed_command
      'rpm -qa | grep'
    end

  end

end

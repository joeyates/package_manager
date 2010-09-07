module PackageManager

  class Rpm < ::PackageManager::Base

    def initialize
      @name = 'rpm'
    end

    private

    def find_installed_command
      'rpm -qa | grep'
    end

    def list_contents_command
      'rpm -q --filesbypkg'
    end

  end

end

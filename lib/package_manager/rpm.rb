module PackageManager

  class Rpm < Base

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

    def install_file_command
      'rpm -ihv'
    end

  end

end

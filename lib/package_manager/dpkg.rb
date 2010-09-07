module PackageManager

  class Dpkg < Base

    def initialize
      @name = 'dpkg'
    end

    private

    def list_contents_command
      'dpkg -L'
    end

    def install_file_command
      'dpkg -i'
    end

  end

end

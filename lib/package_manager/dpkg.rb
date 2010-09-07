module PackageManager

  class Dpkg < Base

    def initialize
      @name = 'dpkg'
    end

    private

    def list_contents_command
      'dpkg -L'
    end

  end

end

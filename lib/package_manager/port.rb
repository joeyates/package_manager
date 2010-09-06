module PackageManager

  class Port < ::PackageManager::Base

    def initialize
      @name = 'port'
    end

    private

    def find_available_command
      'port search'
    end

  end

end

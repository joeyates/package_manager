module PackageManager

  class Yum < Rpm

    def initialize
      @name = 'yum'
    end

    private

    def install_command
      'yum install'
    end

    def uninstall_command
      'yum remove'
    end

  end

end

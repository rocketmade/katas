require 'singleton'

module Cells
  class AliveClass
    include Singleton
    def to_s; "#"; end
    def alive?; true; end
    def dead?; false; end
  end

  class DeadClass
    include Singleton
    def to_s; "-"; end
    def alive?; false; end
    def dead?; true; end
  end
end

def alive; Cells::AliveClass.instance; end
def dead; Cells::DeadClass.instance; end

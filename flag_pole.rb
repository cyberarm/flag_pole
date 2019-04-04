require "gosu"
require_relative "lib/flag"
require_relative "lib/pole"

class Window < Gosu::Window
  def initialize
    super(500, 500, false)

    $window = self

    @flag = Flag.new("flags/norway.png", :half_staff)
    @pole = Pole.new
  end

  def draw
    @pole.draw
    @flag.draw
  end
end

Window.new.show

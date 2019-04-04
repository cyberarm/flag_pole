require "gosu"
require_relative "lib/flag"
require_relative "lib/pole"
require_relative "lib/driver"

class Window < Gosu::Window
  def initialize
    super(500, 500, fullscreen: false, resizable: true)

    $window = self
    @last_frame_time = Gosu.milliseconds

    @flag = Flag.new("flags/#{ARGV[0].strip.downcase}.png")
    @pole = Pole.new
  end

  def draw
    @pole.draw
    @flag.draw
  end

  def update
    @last_frame_time = Gosu.milliseconds

    @pole.update
    @flag.update
  end

  def delta
    @last_frame_time / 1000.0
  end

  def resize(width, height, fullscreen, user_resizing)
    p width, height, fullscreen, user_resizing
    super
  end

  def lose_focus
    puts "Bye"
  end
end

Window.new.show

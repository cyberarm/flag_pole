class Flag
  Slice = Struct.new(:image, :x, :y, :z, :y_offset)

  attr_reader :x, :y, :z, :image
  def initialize(image_path)
    @image = Gosu::Image.new(image_path, retro: true)

    @x = $window.width/2
    @y = $window.height - (@image.height + 10)
    @z = -1

    @two_pi = Math::PI * 2

    @slices = []
    @slice_width = 2

    @wave = 0
    @wave_frequency = 0.1
    @wave_amplitude = 10
    @wave_time = 0

    @font = Gosu::Font.new(28)

    slice_image
  end

  def x=(n)
    @x = n
    @slices.each {|s| s.y = @x}
  end

  def y=(n)
    @y = n
    @slices.each {|s| s.y = @y}
  end

  def z=(n)
    @z = n
    @slices.each {|s| s.y = @z}
  end

  def draw
    # Debuggin anchor line
    # Gosu.draw_line(@x, @y, Gosu::Color::WHITE, $window.width, @y, Gosu::Color::WHITE)

    @slices.each_with_index do |slice, i|
      slice.image.draw(slice.x + @slice_width * i, slice.y + slice.y_offset, slice.z)
    end

    if Gosu.button_down?(Gosu::KbTab)
      @font.draw_text(
"advance_time: #{@advance_time}
Frequency: #{@wave_frequency}
Amplitude: #{@wave_amplitude}
wave_time: #{@wave_time}
wave: #{@wave}
",
        10, 10, 10
      )
    end
  end

  def update
    delta = $window.delta
    @slices.each_with_index do |slice, i|
      slice.y_offset = step_cosine_wave(i)
    end

    @wave_time += 1

    @wave_frequency += 0.01 if Gosu.button_down?(Gosu::KbUp)
    @wave_frequency -= 0.01 if Gosu.button_down?(Gosu::KbDown)
    @wave_amplitude += 0.5 if Gosu.button_down?(Gosu::KbRight)
    @wave_amplitude -= 0.5 if Gosu.button_down?(Gosu::KbLeft)
  end

  def step_cosine_wave(x)
    # @wave_amplitude * Math.cos(@two_pi * @wave_frequency * step)
    @wave = (@wave_amplitude * (Math.cos(@wave_frequency * (@wave_time + x)) + 1) / 2) * x/@image.width - 1
  end

  def slice_image
    (@image.width / @slice_width).times do |i|
      slice = Gosu.render(@slice_width, @image.height) do
        # Shift image to the left for each slice
        @image.draw(-(i * @slice_width),0,0)
      end

      @slices << Slice.new(slice, @x, @y, @z, 0)
    end
  end
end

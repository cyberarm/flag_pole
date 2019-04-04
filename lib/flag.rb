class Flag
  Slice = Struct.new(:image, :x, :y, :z, :y_offset)
  def initialize(image_path)
    @image = Gosu::Image.new(image_path, retro: true)

    @x = $window.width/2
    @y = 10
    @z = -1

    @two_pi = Math::PI * 2

    @slices = []
    @slice_width = 6

    @wave = 0
    @wave_frequency = 0.02
    @wave_amplitude = 4
    @wave_step = 0.005

    @wave_travel = 0
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
    @slices.each_with_index do |slice, i|
      slice.image.draw(slice.x + @slice_width * i, slice.y + slice.y_offset, slice.z)
    end

    if Gosu.button_down?(Gosu::KbTab)
      @font.draw_text(
"
Frequency: #{@wave_frequency}
Amplitude: #{@wave_amplitude}
wave_step: #{@wave_step}
wave_travel: #{@wave_travel}
",
        10, 10, 10
      )
    end
  end

  def update
    delta = $window.delta
    @slices.each_with_index do |slice, i|
      slice.y_offset = step_sine_wave(i + @wave_travel)
    end

    @wave_travel += 1

    # @wave_frequency += 0.01 if Gosu.button_down?(Gosu::KbUp)
    # @wave_frequency -= 0.01 if Gosu.button_down?(Gosu::KbDown)
    # @wave_amplitude += 0.01 if Gosu.button_down?(Gosu::KbRight)
    # @wave_amplitude -= 0.01 if Gosu.button_down?(Gosu::KbLeft)
  end

  def step_sine_wave(time)
    @wave = @wave_amplitude * Math.sin(@two_pi * @wave_frequency * time)
  end

  def slice_image
    (@image.width / @slice_width).times do |i|
      slice = Gosu.render(@slice_width, @image.height) do
        @image.draw(-(i * @slice_width),0,0)
      end

      @slices << Slice.new(slice, @x, @y, @z, 0)
    end
  end
end

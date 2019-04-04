class Flag
  def initialize(image_path, end_position)
    @image = Gosu::Image.new(image_path, retro: true)
    
    @x = $window.width/2
    @y = 10
    @z = -1

    @slices = []
    @slice_width = 4
    @wave = 0
    @wave_factor = 0.2
    @wave_multiplier = 13.0
    @wave_step   = 0.2
    @waveform    = 0

    @wave_travel = 0

    slice_image
  end

  def draw
    @slices.each_with_index do |slice, i|
      step_sine_wave
      slice.draw(@x + @slice_width * i, @y + (@wave * @wave_multiplier), @z)
    end

    @wave_travel += @wave_step
    @wave = @wave_travel
  end

  def step_sine_wave
    @waveform += @wave_step
    @wave = (Math.sin(@waveform) * @wave_factor)
  end

  def slice_image
    (@image.width / @slice_width).times do |i|
      slice = Gosu.render(@slice_width, @image.height) do
        @image.draw(-(i * @slice_width),0,0)
      end

      @slices << slice
    end
  end
end

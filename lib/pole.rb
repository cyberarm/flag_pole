class Pole
  def initialize
    @base_width = 100
    @base_height = 20
    @base_color = Gosu::Color::GRAY

    @staff_width = 8
    @staff_height = $window.height
    @staff_color = Gosu::Color::GRAY

  end

  def draw
    # BASE
    Gosu.draw_rect(
      $window.width/2 - @base_width/2,
      $window.height - @base_height,
      @base_width, @base_height,

      @base_color
    )

    # STAFF
    Gosu.draw_rect(
      $window.width/2 - @staff_width/2,
      0,
      @staff_width, @staff_height,

      @staff_color
    )
  end
end
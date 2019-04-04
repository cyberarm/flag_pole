class Driver
  def initialize(flag, end_position = :full_staff)
    @flag = flag
    @end_position = end_position
    # :full_staff
    # :half_staff
    # :low_staff

    @full_staff_speed = 1
    @half_staff_speed = 0.1
    @low_staff_speed  = 1

    @y_padding = 10
  end

  def update
    case @end_position
    when :full_staff
      raise_to_full_staff unless @raised_to_full_staff
    when :half_staff
      raise_to_full_staff unless @raised_to_full_staff
      lower_to_half_staff if @raised_to_full_staff && !@lowered_to_half_staff

    when :low_staff
      raise_to_full_staff unless @raised_to_full_staff
      lower_to_low_staff if @raised_to_full_staff && !@lowered_to_low_staff
    end
  end

  def raise_to_full_staff
    unless @flag.y <= @y_padding
      @flag.y -= @full_staff_speed
    else
      @raised_to_full_staff = true
    end
  end

  def lower_to_half_staff
    unless @flag.y >= $window.height/2 - @flag.image.height/2
      @flag.y += @half_staff_speed
    else
      @lowered_to_half_staff = true
    end
  end

  def lower_to_low_staff
    unless @flag.y >= $window.height - (@flag.image.height + 10)
      @flag.y += @low_staff_speed
    else
      @lowered_to_low_staff = true
    end
  end
end
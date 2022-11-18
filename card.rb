class Card

  attr_reader :face_value, :face_down

  def initialize(face_value)
    @face_value = face_value
    @face_down = true  
  end

  def display
    return @face_value unless @face_down
  end

  def hide
    @face_down = true
    display
  end

  def reveal
    @face_down = false
    display
  end

  def to_s
    @face_value.to_s
  end

  def ==(other)
    if !other || !self
      return false
    else 
      self.face_value.to_s == other.face_value.to_s
    end
  end
end
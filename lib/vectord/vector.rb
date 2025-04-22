
module Game
  class Vector
    attr_accessor :x, :y
    def initialize(x, y)
      @x = x
      @y = y
    end
    def +(a)
      if a.is_a?(Numeric)
        raise "cannot add a scalar to a vector"
      elsif a.is_a?(Vector)
        return Vector.new(a.x + @x, a.y+@y)
      end
    end
    def *(a)
      if a.is_a?(Numeric)
        return Vector.new(a * @x, a * @y)
      elsif a.is_a?(Vector)
        raise "Not sure if vector to vector mult is necessary"
      end
    end
    def -(a)
      if a.is_a?(Numeric)
        raise "cannot subtract a vector and a scalar"
      elsif a.is_a?(Vector)
        return Vector.new(@x - a.x, @y - a.y)
      end
    end
    def set(a)
      if a.is_a?(Numeric)
        @x = a
        @y = a
      end
    end
    def -@

        return Vector.new(-@x, -@y)

    end
    def Up
        @y = 1

    end
    def Left

      @x = -1
    end
    def Right

      @x = 1
    end
    def Down
      @y = -1

    end

  end
end
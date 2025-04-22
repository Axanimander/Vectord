
module Game
  class Rectangle
    attr_accessor :w, :h, :left, :right, :top, :bottom, :pos, :cleft, :cright, :cbottom, :ctop
    def initialize(x, y, h, w, camera)
      @pos = Vector.new(x, y)
      @h = h
      @w = w
      @camera = camera

      @left = @pos.x - @camera.x
      @right = (@pos.x + @w) - @camera.x
      @top = @pos.y - @camera.y
      @bottom = (@pos.y - @h) - camera.y
      @@c = Gosu::Color.argb(0xff_ffffff)

    end
    def draw
      Gosu::draw_line(@pos.x, @pos.y, @@c, @pos.x + @w, @pos.y, @@c, z = 0, mode = :default)
      Gosu::draw_line(@pos.x, @pos.y, @@c, @pos.x, @pos.y + @h, @@c, z = 0, mode = :default)
      Gosu::draw_line(@pos.x + @w, @pos.y,@@c, @pos.x + @w, @pos.y + @h, @@c, z = 0, mode = :default)
      Gosu::draw_line(@pos.x - 1, @pos.y + @h, @@c, @pos.x + @w, @pos.y + @h, @@c, z = 0, mode = :default)

    end
    def collide(r2)

      return !(r2.left > @right || r2.right < @left || r2.top > @bottom || r2.bottom < @top)

    end
    def move(v1)
      @pos = pos + v1
      @left = v1.x
      @right = v1.x + @w
      @top = v1.y
      @bottom = v1.y + @h


    end
    def is_inside(r2)
     return (r2.left > @right || r2.right < @left || r2.top > @bottom || r2.bottom < @top)
    end
    def cameraposition(camera)
      @camera = @pos - camera.worldpos
    end
  end
end
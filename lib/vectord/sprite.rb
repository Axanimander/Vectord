
  class Sprite
    attr_accessor :vel, :collided, :rectangleList, :spriteRect, :pos
    def initialize(x, y, rectangleList = [])
      @x = x
      @y = y
      @pos = Vector.new(@x, @y)
      @camera = Vector.new(@x, @y)
      @rectangleList = rectangleList
      @collided = 0

      @vel = Vector.new(0, 0)
      @spriteRect = Rectangle.new(@x, @y, 20, 20, @camera)
      addRect(Rectangle.new(@camera.x, @camera.y, 20, 20, @camera))
    end
    def addRect(rect)
      rect.pos = @pos + rect.pos
      @rectangleList << rect
    end
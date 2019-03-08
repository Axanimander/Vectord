require 'gosu'
require 'absolute_time'
module Game
  class Game < Gosu::Window
    def initialize
      @windowWidth = 640
      @windowHeight = 480
      super(@windowWidth, @windowHeight, false)
      @gamestate = GameState.new

    end

    def update()
     # @map.update
      @gamestate.update
    end

    def draw()
    #  @map.draw

      @gamestate.camera.drawscene

      p"#{Gosu.fps}"


    end

    def button_down(id)
      @gamestate.buttonhandler.handlebuttondown(id)
    end

    def button_up(id)

      @gamestate.buttonhandler.handlebuttonup(id)
    end
  end

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
    def draw
      @rectangleList.each do |rect|
        rect.draw

      end
    end
    def collide(othersprite)
      @rectangleList.each do |rect|
        othersprite.rectangleList.each do |rect2|
          if rect.collide(rect2)
            rebound
            p "collision"

          end
        end
      end
    end
    def move(x, y)
      @vel.x += x
      @vel.y += y

    end
    def update

      @pos += @vel
      @spriteRect.pos = @pos
      @rectangleList.each do |rect|
        rect.move(@vel)

      end
    end
    def rebound
      @vel.x = 0
      @vel.y = 0
      update
      @vel.x = 0
      @vel.y = 0
    end
    def cameraposition(camera)
     @camera = @pos - camera.worldpos
    end
  end


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
  class Camera
    attr_accessor :worldpos
      def initialize(world)
        @world = world

        @worldpos = Vector.new(0, 0)
        @viewpanerect = 400
        @cameraRect = Rectangle.new(@worldpos.x, @worldpos.y, @viewpanerect, @viewpanerect, worldpos)
      end
      def movecamera(v1)
        @worldpos = v1
        update
      end
      def update
        @cameraRect.move(@worldpos)

      end
      def movecamerarelative(v1)
        @worldpos += v1
        update
      end
      def drawscene
        @world.spritelist.each do |sprite|
          if contains(sprite)

            sprite.draw
          elsif !contains(sprite)

         end
        end
        end
      def contains(sprite)
        return @cameraRect.is_inside(sprite.spriteRect)
      end
  end
  class World
    attr_accessor :spritelist
      def initialize
        @worldsize = 4000
        @spritelist = []

      end
      def draw_world()

      end
      def addsprite(sprite)
        @spritelist << sprite
      end
      def update
        @spritelist.each do |sprite|
          sprite.update
        end
        findcollides

        end
        def findcollides
          @spritelist.each do |sprite|
            @spritelist.each do |sprite2|
              if  sprite2 != sprite
                sprite.collide(sprite2)
              else
                break
              end
            end
          end
        end
  end
  class GameState
    attr_accessor :world, :camera, :player1, :buttonhandler, :fps, :t
    def initialize
      @player1 = Sprite.new(20, 20)
      @thing = Sprite.new(50, 20)
      @world = World.new
      @world.addsprite(@player1)
      @world.addsprite(@thing)
      @camera = Camera.new(@world)
      @buttonhandler = ButtonHandler.new(@player1, @camera)
    end
    def update
      @world.update
      @camera.update
      @world.spritelist.each do |sprite|
        sprite.cameraposition(@camera)

      end

    end
end
  class ButtonHandler
      def initialize(player, camera)
          @camera = camera
          @context = :in_game
          @sp1 = player
      end
      def handlebuttonup(id)

        case id
          when Gosu::KbDown then @sp1.vel.y = 0
          when Gosu::KbUp then @sp1.vel.y = 0
          when Gosu::KbLeft then @sp1.vel.x = 0
          when Gosu::KbRight then @sp1.vel.x = 0

        end
      end
      def handlebuttondown(id)

        case id
          when Gosu::KbDown then @sp1.move(0, 1)
          when Gosu::KbUp then @sp1.move(0, -1)
          when Gosu::KbLeft then @sp1.move(-1, 0)
          when Gosu::KbRight then @sp1.move(1, 0)
          when Gosu::KbD then @camera.worldpos.y += 1
          when Gosu::KbA then @camera.worldpos.y -= 1
          when Gosu::KbS then @camera.worldpos.x += 1
          when Gosu::KbW then @camera.worldpos.x -= 1
        end

      end
      def handlebuttondown2(id)
       v1 = Vector.new(0, 0)
        case id
          when Gosu::KbDown then v1.Down
          when Gosu::KbUp then  v1.Up
          when Gosu::KbLeft then  v1.Left
          when Gosu::KbRight then  v1.Right
          when Gosu::KbD then v2.Right
          when Gosu::KbA then v2.Left
          when Gosu::KbS then v2.Down
          when Gosu::KbW then v2.Up
        end
        @sp1.move(v1.x, v1.y)
        @camera.move(v2)
      end
  end

  game = Game.new
  game.show
end

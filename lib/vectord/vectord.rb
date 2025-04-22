require 'gosu'
require 'absolute_time'
module Game

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

  game = Game.new
  game.show
end


module Game
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
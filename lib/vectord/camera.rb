
module Game
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
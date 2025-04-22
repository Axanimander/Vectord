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

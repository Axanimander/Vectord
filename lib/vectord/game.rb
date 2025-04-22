
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
require 'gosu'
require_relative 'snake'
require_relative 'food'
require 'pry-byebug'

SIZE = 20

class Game < Gosu::Window
  def initialize
    @ref = SIZE * 16
    super(@ref, @ref)
    self.caption = "Snake game"

    @snake = Snake.new(SIZE)
    @food = Food.new(SIZE)
    @trigger = false
    @time = 0
    @game_lost = false
    initialize_sound
    @speed = 500
  end

  def initialize_sound
    @font = Gosu::Font.new(20)
    @eat_sound = Gosu::Sample.new("eat.wav")
    @lost_sound = Gosu::Sample.new("lost.wav")
  end

  def update
    unless @game_lost
      eat if @food.pos == @snake.pos
      change_dir

      if Gosu.milliseconds - @time > @speed
        @snake.move
        @time = Gosu.milliseconds
      end

      game_lost?
    end
  end

  def draw
    if @game_lost
      @font.draw_text("GAME OVER", SIZE * 3, SIZE * 7, 10, 2.0, 2.0, Gosu::Color::RED)
      @font.draw_text("Score: #{@snake.length.size}", SIZE * 7, SIZE * 9, 10, 1.0, 1.0, Gosu::Color::RED)
    else
      @food.draw
      @snake.draw
    end
  end

  def change_dir
    x = y = 0
    @snake.change_dir(-1, y) if Gosu.button_down? Gosu::KB_LEFT
    @snake.change_dir(1, y) if Gosu.button_down? Gosu::KB_RIGHT
    @snake.change_dir(x, -1) if Gosu.button_down? Gosu::KB_UP
    @snake.change_dir(x, 1) if Gosu.button_down? Gosu::KB_DOWN
  end

  def eat
    @speed /= 1.1
    @snake.add
    @eat_sound.play(0.05)
    @food = Food.new(SIZE)
  end

  def game_lost?
    hit_walls = @snake.pos[:x].negative? || @snake.pos[:x] > @ref || @snake.pos[:y].negative? || @snake.pos[:y] > @ref
    hit_self = @snake.length.size > 2 && @snake.length[2..].include?(@snake.pos)
    if hit_walls || hit_self
      @lost_sound.play(0.05)
      @game_lost = true
    end
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

Game.new.show

require 'gosu'


class Snake
  attr_reader :width, :height
  attr_accessor :pos, :dir, :length

  def initialize(size)
    @width = size
    @height = size
    @pos = { :x => @width * 8, :y => @height * 8 }
    @length = [{ :x => @width * 8, :y => @height * 8 }]
    @dir = { :x => 0, :y => 0 }
  end

  def draw
    @length.each do |pos|
      Gosu.draw_rect(pos[:x], pos[:y], @width, @height, Gosu::Color::WHITE)
    end
  end

  def move
    @pos[:x] += (@dir[:x] * @width)
    @pos[:y] += (@dir[:y] * @height)
    @length.unshift({ :x => @pos[:x], :y => @pos[:y] })
    @length.pop
  end

  def add
    @length.push(@length[-1])
  end

  def change_dir(dir_x, dir_y)
    @dir[:x] = dir_x
    @dir[:y] = dir_y
  end
end

require 'gosu'


class Food
  attr_reader :width, :height
  attr_accessor :pos

  def initialize(size)
    @width = size
    @height = size
    @pos = { :x => @width * rand(0..15), :y => @height * rand(0..15) }
  end

  def draw
    Gosu.draw_rect(@pos[:x], @pos[:y], @width, @height, Gosu::Color::RED)
  end
end

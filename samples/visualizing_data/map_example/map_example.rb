require 'ruby-processing'
# require 'rubygems'
require 'csv'


class MapExample < Processing::App

  def setup
    @img = load_image("map.png")
    @rowcount = 0
    @locations = []
    @data = []
    CSV.open("./samples/visualizing_data/map_example/data/random.tsv", 'r', col_sep = "\t") do |row|
       @data << row
    end

    # Data matrix is transposed, and row 1 is the values for every state
    puts @data[0][1]
    puts @data.size
    @data_min = @data.transpose[1].min.to_f
    @data_max = @data.transpose[1].max.to_f
  end
    
    def draw
       background 0
       image @img, 0, 0

      CSV.open("./samples/visualizing_data/map_example/data/locations.tsv", 'r', col_sep = "\t") do |row|
         x_position = row[1].to_i
         y_position = row[2].to_i
         @locations << [x_position, y_position]
       end

       # each_with_index brings in @locations, an array of other two-member
       # arrays.  The two members are the x and y coordinates, accessed here
       # as xy[0] for x and xy[1] for y. Index numbers them to access the
       # the equivalent line number in @data, but it is not accessed by
       # state name as in the original example.
       @locations.each_with_index do |xy, index|
         value = @data[index][1].to_f
         puts value
         size = map(value, @data_min, @data_max, 2, 40)
         # map function is from processing, NOT from ruby.  It takes a
         # value, then two ranges of numbers.  The first range is the
         # original data min/max, and the second is target min/max.
         # It then scales the value to its proporional position in
         # the new range.  Ruby's map function is totally different.
         percent = norm(value, @data_min, @data_max)
         puts percent
         between = lerp_color("FF4422".hex, "4422CC".hex, percent) # 4th parameter is HSB
         fill between
         ellipse xy[0], xy[1], size, size
       end
    end

end

MapExample.new :title => "Map Test", :width => 640, :height => 400
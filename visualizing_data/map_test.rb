require 'ruby-processing'
# require 'rubygems'
require 'csv'


class MapTest < Processing::App

  def setup
    @img = load_image("map.png")
    @rowcount = 0
    @locations = []
    @data = []
    CSV.open("./visualizing_data/data/random.tsv", 'r', col_sep = "\t") do |row|    
       @data << row
    end
    
    # Data matrix is transposed, and row 1 is the values for every state
    puts @data[0][1]
    @data_min = @data.transpose[1].min
    @data_max = @data.transpose[1].max
    

    
  end
  
  def draw
    background 0
    image @img, 0, 0
    
   CSV.open("./visualizing_data/data/locations.tsv", 'r', col_sep = "\t") do |row|
      x_position = row[1].to_i
      y_position = row[2].to_i
      @locations << [x_position, y_position]
    end
    
    @locations.each do |x,y|
      fill 255, 0, 0
      ellipse x, y, 9, 9
    end  
  
    
  end
  
end

MapTest.new :title => "Map Test", :width => 640, :height => 400

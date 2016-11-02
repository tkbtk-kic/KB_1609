
class Geo_Analysis

  attr_reader :hot_spots

  def initialize(geo_tags, thresh=6, neightborhood = 0.001)
    @thresh = thresh + 1 # hot-spotとする下限
    @geo_info =[] # geo tagの一覧と ご近所さん結果
    @hot_spots = [] # hot spotの結果
    @neigh = neightborhood ** 2
    @squear = []
    @geo_buf= []
    i=0
    geo_tags.each do |row|
      @geo_info.push({:id => i, :lat=> row[0], :lon => row[1], :neigh => []})
      i += 1
    end
    self.analyze
  end

  def analyze
    @geo_buf =@geo_info
    self.find_neigh
    while
    ((raw = @geo_buf.max_by{|max|
      max[:neigh].size
    })[:neigh].size >= @thresh)
      @hot_spots << self.avarage(raw)
      self.remove_geo(raw[:neigh])
    end
  end

  def find_neigh
    @geo_buf.each do |n|
      @geo_buf.each do |q|
        if ((n[:lat] - q[:lat]).abs <= @neigh && (n[:lon] - q[:lon]).abs <= @neigh)
          @squear << q
        end
      end
      @squear.each do |s|
        if( ((n[:lat] - s[:lat])**2 + (n[:lon] - s[:lon]) ** 2) <= @neigh )
          n[:neigh] << s[:id]
        end
      end
      # p n[:neigh]
    end
  end

  def avarage(ava)
    count = 0
    result =[0,0]
    ava[:neigh].each do |id|
      @geo_info.each do |raw|
        if(id==raw[:id])
          result[0] += raw[:lat]
          result[1] += raw[:lon]
          count += 1
        end
      end
    end
    result[0] /= count
    result[1] /= count
    return result
  end

  def remove_geo(ids)
    ids.each do |id|
      @geo_buf.delete(@geo_buf.find{|item| item[:id] == id})
    end
  end

  def thresh=(thresh)
    @thresh = thresh
    self.analyze
  end

  def neightborhood=(neightborhood)
    @neigh = neightborhood
    self.analyze
  end
end


# geo_tags = [[34.701234, 135.189666], [34.701385, 135.189516], [34.701039, 135.18991], [34.701622, 135.190088], [34.702358, 135.190568], [34.702423, 135.192115], [34.702366, 135.190811], [34.700914, 135.190675], [34.700932, 135.191524], [34.701301, 135.19149], [34.701245, 135.191548], [34.699618, 135.193126], [34.69983, 135.190226], [34.698321, 135.191102], [34.701042, 135.189356], [34.694749, 135.190626], [34.69889, 135.193623], [34.701397, 135.189779], [34.701378, 135.189573], [34.701257, 135.189652]]
#
# geo_analysis = Geo_Analysis.new(geo_tags)
#
# p geo_analysis.hot_spots
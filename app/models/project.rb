class Project < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_and_belongs_to_many :search_engines
  has_many :keywords, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :domain
  
  def process
    self.search_engines.each do |se|
      logger.debug "SearchEngine #{se.short_name} scanning:"
      self.keywords.each do |keyword|
        logger.debug "Keyword: #{keyword.name}"
        keyword.process(se)
      end
    end
  end
  
  def competitors
    h = ActiveSupport::OrderedHash.new
    KeywordReport.select("domain, sum(avg_position) as position").where(:keyword_id => self.keyword_ids).group("domain").order("position desc").all.each{|rec| h[rec.domain] = rec.position}
    h
  end
  
  
end

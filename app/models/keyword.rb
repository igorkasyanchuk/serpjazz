class Keyword < ActiveRecord::Base
  belongs_to :project, :counter_cache => true

  has_many :keyword_positions, :dependent => :destroy
  has_many :keyword_reports, :dependent => :destroy

  validates_presence_of :name
  
  ENGINES = {
    'google' => {
      :domain => "http://google.com.ua/"
    }
  }
  
  def check(se)
    method = "google" # TODO
    Keyword.send("check_#{method}", self.name, se.domain, 2, 10) # TODO dependent on plan
  end
  
  def competitors
    h = ActiveSupport::OrderedHash.new
    self.keyword_reports.select("domain, sum(avg_position) as position").group("domain").order("position desc").all.each{|rec| h[rec.domain] = rec.position}
    h
  end
  
  def process(search_engine)
    log_to STDOUT
    _tmp = self.check(search_engine)
    _tmp.each do |domain, record|
      self.keyword_reports.create({
        :domain => domain,
        :avg_position => record[:index],
        :positions => record[:positions].join(','),
        :max_position => record[:positions].max || -1,
        :running_on => Time.zone.now
      })
    end
  end
  
  def project_domain_exists_in_results?
    self.domain_exists_in_results?(self.project.domain)
  end
  
  def domain_exists_in_results?(domain)
    self.keyword_reports.where(:domain => domain).count > 0
  end
  
  def Keyword.check_google(keyword, domain='http://google.com.ua/', steps=3, step=10)
    search_pattern = domain + "search?&q=" + CGI.escape(keyword)
    agent = Mechanize.new
    domains = {}
    index = 0
    steps.times do |n|
      page = agent.get(search_pattern + "&start=#{n*step}")
      doc = Nokogiri::HTML(page.body)
      stat_index = 1
      doc.css("h3.r a").each do |holder|
        domain_ext = holder["href"]
        domain = URI.parse(URI.encode(domain_ext)).host.gsub(/^www\./, '') rescue next
        domains[domain] ||= {}
        domains[domain][:index] ||= 0
        domains[domain][:percentages] ||= []
        domains[domain][:positions] ||= []
        percentage = CLICK_STAT[stat_index] / (n*n*n*100+1)
        domains[domain][:index] += percentage
        domains[domain][:percentages] << percentage
        domains[domain][:positions] << (index+1)
        index += 1
        stat_index += 1
      end
      sleep(0.5)
    end  
    domains
  end
  
  def Keyword.print_domains(domains)
    puts "%-30s : %10s : %-25s" % [ "Domain", 'Clicks, %', 'Positions' ]
    puts "----------------------------------------------------------"
    domains.sort{|a, b| b[1][:index] <=> a[1][:index]}.each do |domain, info|
      puts "%-30s : %4f   : %-25s" % [ domain, info[:index], info[:positions].join(', ') ]
    end  
  end
  
end

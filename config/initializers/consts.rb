GOOGLE_KEYS = {
  "development" => "ABQIAAAA-fvnmbkR8BJ_xVoxel7PfhSvcDMizmiBvzrB1F5eJeU6gK2K7RQW3Pfw8DmhMhUuewSuQjcD20SoUA",
  "test" => "ABQIAAAA-fvnmbkR8BJ_xVoxel7PfhSvcDMizmiBvzrB1F5eJeU6gK2K7RQW3Pfw8DmhMhUuewSuQjcD20SoUA",
  "production" => "ABQIAAAAeGlGRfeULyAPWr3-syWI4xTUvJdBBoS-HuHv63g54CTdGhrVoxRCjaS0Cha9M4XtxuV_NKHRQ7TNCQ"
}

STATES = [:alabama, :alaska, :arizona, :arkansas,
          :california, :colorado, :connecticut,
          :delaware, :florida, :georgia, :hawaii, :idaho,
          :illinois, :indiana, :iowa, :kansas,
          :kentucky, :louisiana, :maine, :maryland,
          :massachusetts, :michigan, :minnesota, :mississippi,
          :missouri, :montana, :nebraska, :nevada,
          :new_hampshire, :new_jersey, :new_mexico,
          :new_york, :north_carolina, :north_dakota,
          :ohio, :oklahoma, :oregon, :pennsylvania,
          :rhode_island, :south_carolina, :south_dakota,
          :tennessee, :texas, :utah, :vermont, :virginia,
          :washington, :west_virginia, :wisconsin, :wyoming].collect{|e| e.to_s.camelize.titleize }

days_for_specials = ActiveSupport::OrderedHash.new
days_for_specials[:monday] = 'MON'
days_for_specials[:tuesday] = 'TUE'
days_for_specials[:wednesday] = 'WED'
days_for_specials[:thursday] = 'THU'
days_for_specials[:friday] = 'FRI'
days_for_specials[:saturday] = 'SAT'
days_for_specials[:sunday] = 'SUN'

DAYS_FOR_SPECIALS = days_for_specials

TIMES_ARRAY = [ "6am", "6:30am", "7am", "7:30am", "8am", "8:30am", 
"9am", "9:30am", "10am", "10:30am", "11am", "11:30am", "Noon", "12:30pm", "1pm", 
"1:30pm", "2pm", "2:30pm", "3pm", "3:30pm", "4pm", "4:30pm", "5pm", "5:30pm", 
"6pm", "6:30pm", "7pm", "7:30pm", "8pm", "8:30pm", "9pm", "9:30pm", "10pm",
"10:30pm", "11pm", "11:30pm", 'Midnight', "12:30am", "1am", "1:30am", "2am", "2:30am", "3am", "3:30am", "4am",
"4:30am", "5am", "5:30am" ]

TIME_NOW = Time.now.to_i

DEFAULT_DETAILED_ZOOM = 13
DEFAULT_CITY_ZOOM = 10

SEO_TITLE = "Happy Hour Scout - Finding Happy Hours and Bar Specials for You!"
SEO_TITLE_SHORT = "HappyHourScout.com"
SEO_DESCRIPTION = "Happy Hour Scout - Finding Happy Hours and Bar Specials for You!"
SEO_KEYWORDS = "happy hour, bars, specials, drinks, find bar, find specials, friends, fun"
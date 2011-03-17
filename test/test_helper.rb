ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "webrat"
require 'webrat/core/matchers'
include Webrat::Methods
require 'pp'

Webrat.configure do |config|
  config.mode = :rack
end

class ActiveSupport::TestCase
  fixtures :all
end

module Test::Unit::Assertions
  def assert_false(object, message="")
    assert_equal(false, object, message)
  end
end

require 'sequences.rb'

FILE_FOR_UPLOAD = "#{Rails.root}/test/upload.txt"
IMAGE_FILE_FOR_UPLOAD = "#{Rails.root}/test/test_image.png"
VIDEO_FILE_FOR_UPLOAD = "#{Rails.root}/test/video.flv"

Geokit::Geocoders::MultiGeocoder.stubs(:geocode).returns(nil)
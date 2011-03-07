ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webrat'
require 'faker'
require 'mocha'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
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

Location.any_instance.stubs(:geocode_it!).returns(true)
Geokit::Geocoders::MultiGeocoder.stubs(:geocode).returns(nil)

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  test "correctly update budget" do
    @project = Factory(:project)
    assert_equal @project.keywords.count, 0
    assert_equal @project.search_engines.count, 1
  end

end

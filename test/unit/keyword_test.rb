require 'test_helper'

class KeywordTest < ActiveSupport::TestCase
  
 # test "checking keywords" do
 #   @project = Factory(:project)
 #   @se = @project.search_engines.first
 #   keyword = @project.keywords.create(:name => 'проживання гута')
 #   checking_results = keyword.check(@se)
 #   Keyword.print_domains(checking_results)
 # end
  
  test "processing keywords" do
    @project = Factory(:project)
    keyword = @project.keywords.create(:name => 'проживання гута')
    @project.keywords.create(:name => 'проживання ворохта')
    @project.keywords.create(:name => 'відпочинок карпати')
    
    @project.process
    assert keyword.project_domain_exists_in_results?
    assert_false keyword.domain_exists_in_results?("ff.com")
    
    pp keyword.competitors
    
    pp @project.competitors
  end

end

require File.dirname(__FILE__) + '/spec_helper'

describe "Code-Search", :type => :request do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "it should display the search page" do
    visit '/code-search'
    page.should have_content("What type of business?")
  end

  it "should return results" do
    visit '/code-search'
    fill_in 'query', :with => 'Yoga'
    click_on 'Submit'
    page.should have_content('NAICS Codes')
    page.should have_content('611699')
  end

  it "should ignore case" do
    visit '/code-search'
    fill_in 'query', :with => 'Construction'
    click_on 'Submit'
    upper = page.html
    fill_in 'query', :with => 'construction'
    click_on 'Submit'
    lower = page.html
    upper.should eq(lower)
  end

end



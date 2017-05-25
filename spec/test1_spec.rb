require_relative "../util/spec_helper"

describe "Hudl repo" do
  it "search text on google" do
    @browser.manage.timeouts.implicit_wait = 5
    @browser.manage.window.resize_to(1280, 720)
    @browser.get('http://www.hudl.com/login')
    @browser.manage.add_cookie(:name => 'CB_REPLACE', :value => "CB_REPLACE")
    @browser.get('http://www.hudl.com/home')
    @browser.save_screenshot("x.png")
  end
end

require "spec_helper"

describe "Guinea Pig Comments" do
  it "Verify comments text" do

    text = "This is a comment"
    @driver.find_element(id: 'comments').click
    @driver.find_element(id: 'comments').send_keys text
    @driver.find_element(id: 'h1Text').click

    @driver.find_element(id: 'submit').click

    Selenium::WebDriver::Wait.new.until { @driver.find_element(id: 'submittedComments') }
    comment = @driver.find_element(id: 'submittedComments').text

    expect(comment).to eq text
  end
end

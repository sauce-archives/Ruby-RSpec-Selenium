require "spec_helper"

describe "Guinea Pig Comments" do
  it "Verify comments text" do

    text = "This is a comment"
    @driver.find_element(id: 'comments').click
    @driver.find_element(id: 'comments').send_keys text
    @driver.find_element(id: 'Heading1_1').click

    @driver.find_element(id: 'submit').click

    Selenium::WebDriver::Wait.new.until { @driver.find_element(id: 'your_comments') }
    comment = @driver.find_element(id: 'your_comments').text

    expect(comment).to eq text
  end
end

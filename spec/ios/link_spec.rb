require "spec_helper"

describe "Guinea Pig Link" do
  it "Verify Link opens page with correct title" do
    @driver.find_element(id: 'i am a link').click
    Selenium::WebDriver::Wait.new.until { @driver.find_elements(id: 'i am a link').size == 0 }
    expect { @driver.find_element(id: 'i am a link') }.to raise_error Selenium::WebDriver::Error::NoSuchElementError
  end
end

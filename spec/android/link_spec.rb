require "spec_helper"

describe "Guinea Pig Link" do
  it "Verify Link opens page with correct title" do
    @driver.find_element(id: 'i_am_a_link').click

    expect { @driver.find_element(id: 'i_am_a_link') }.to raise_error Selenium::WebDriver::Error::NoSuchElementError
  end
end

require "spec_helper"

describe "Guinea Pig Link" do
  it "Verify Link opens page with correct title" do
    @driver.navigate.to "https://saucelabs-sample-test-frameworks.github.io/training-test-page/"
    @driver.find_element(id: 'i_am_a_link').click

    expect(@driver.title).not_to eq "I am a page title - Sauce Labs"
  end
end

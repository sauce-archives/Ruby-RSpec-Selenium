require "spec_helper"

describe "Guinea Pig Comments" do
  it "Verify comments text" do
    @driver.navigate.to "https://saucelabs-sample-test-frameworks.github.io/training-test-page/"

    text = "This is a comment"
    @driver.find_element(id: 'comments').send_keys text
    @driver.find_element(id: 'submit').click

    comment = @driver.find_element(id: 'your_comments').text[/^Your comments: (.*)/, 1]

    expect(comment).to eq text
  end
end

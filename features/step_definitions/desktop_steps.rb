Given 'I am on the Guinea Pig homepage' do
  @driver.navigate.to "https://saucelabs-sample-test-frameworks.github.io/training-test-page/"
end

Then /I should be on another page/ do
  expect(@driver.title).not_to eq "I am a page title - Sauce Labs"
end

And 'I click on the link' do
  @driver.find_element(id: 'i_am_a_link').click
end

When /^I submit a comment$/ do
  @comment = "This is a comment"

  @driver.find_element(id: 'comments').send_keys @comment
  @driver.find_element(id: 'submit').click
end

Then /^I should see that comment displayed$/ do
  comment = @driver.find_element(id: 'your_comments').text[/^Your comments: (.*)/, 1]
  expect(comment).to eq @comment
end

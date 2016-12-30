Given 'I am on the Guinea Pig homepage' do
  return if @mobile
  @driver.navigate.to "https://saucelabs-sample-test-frameworks.github.io/training-test-page/"
end

When 'I click on the link' do
  @id = @platform == 'ios' ? "i am a link" : "i_am_a_link"
  @driver.find_element(id: @id).click
  Selenium::WebDriver::Wait.new.until { @driver.find_elements(id: @id).size == 0 }
end

When /^I submit a comment$/ do
  @comment = "This is a comment"

  @driver.find_element(id: 'comments').click
  @driver.find_element(id: 'comments').send_keys @comment

  if @platform == 'Android'
    @driver.find_element(id: 'Heading1_1').click
  elsif @platform == 'ios'
    @driver.find_element(id: 'h1Text').click
  end

  @driver.find_element(id: 'submit').click
end

Then /I should be on another page/ do
  expect { @driver.find_element(id: @id) }.to raise_error Selenium::WebDriver::Error::NoSuchElementError
end

Then /^I should see that comment displayed$/ do
  comment = case @platform
              when 'Android'
                @driver.find_element(id: 'your_comments').text
              when 'ios'
                @driver.find_element(id: 'submittedComments').text
              else
                @driver.find_element(id: 'your_comments').text[/^Your comments: (.*)/, 1]
            end
  expect(comment).to eq @comment
end

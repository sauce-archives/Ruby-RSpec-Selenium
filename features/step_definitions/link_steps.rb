When 'I click on the link' do
  @id = @platform == 'ios' ? "i am a link" : "i_am_a_link"
  @driver.find_element(id: @id).click
  Selenium::WebDriver::Wait.new.until { @driver.find_elements(id: @id).size == 0 }
end

Then /I should be on another page/ do
  expect { @driver.find_element(id: @id) }.to raise_error Selenium::WebDriver::Error::NoSuchElementError
end

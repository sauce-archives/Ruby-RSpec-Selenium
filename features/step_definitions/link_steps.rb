When 'I click on the link' do
  @page.follow_link
end

Then /I should be on another page/ do
  expect(@page.on_page?).to eq false
end

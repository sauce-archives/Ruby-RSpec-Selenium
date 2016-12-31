When /^I submit a comment$/ do
  @comment_input = "This is a comment"
  @page.submit_comment(@comment_input)
end

Then /^I should see that comment displayed$/ do
  expect(@page.comment).to eq @comment_input
end

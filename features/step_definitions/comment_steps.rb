When /^I submit a comment$/ do
  @comment_input = @page.data_for(:comments)['comment_input']
  @page.submit_comment
end

Then /^I should see that comment displayed$/ do
  expect(@page.comment).to eq @comment_input
end

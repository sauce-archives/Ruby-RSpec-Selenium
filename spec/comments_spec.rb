require "spec_helper"

describe "Guinea Pig Comments" do
  it "Verify comments text" do
    page = GuineaPigPage.new
    page.load

    comment_input = "This is a comment"

    page.submit_comment(comment_input)

    expect(page.comment).to eq comment_input
  end
end

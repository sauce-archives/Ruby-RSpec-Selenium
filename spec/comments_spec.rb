require "spec_helper"

describe "Guinea Pig Comments" do
  it "Verify comments text" do
    page = GuineaPigPage.visit
    comment = CommentModel.new

    page.submit_comment(comment)

    expect(page.comment).to eq comment.comment_input
  end
end

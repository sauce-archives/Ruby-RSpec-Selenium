require "spec_helper"

describe "Guinea Pig Link" do
  it "Verify Link opens page with correct title" do
    page = GuineaPigPage.new
    page.load
    page.follow_link

    expect(page.on_page?).to eq false
  end
end

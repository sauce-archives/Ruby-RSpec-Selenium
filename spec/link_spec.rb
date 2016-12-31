require "spec_helper"

describe "Guinea Pig Link" do
  it "Verify Link opens page with correct title" do
    page = GuineaPigPage.visit
    page.follow_link

    expect(page.on_page?).to eq false
  end
end

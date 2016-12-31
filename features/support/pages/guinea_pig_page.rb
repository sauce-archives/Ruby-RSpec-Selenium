require 'page-object'

class GuineaPigPage
  include PageObject
  include DataMagic

  page_url "https://saucelabs-sample-test-frameworks.github.io/training-test-page/"

  text_area(:comment_input, id: "comments")
  span(:comment_display, id: "your_comments")
  button(:submit, id: 'submit')
  link(:a_link, id: 'i_am_a_link')

  def follow_link
    self.a_link
  end

  def on_page?
    self.a_link_element.exists?
  end

  def submit_comment
    populate_page_with data_for :comments
    self.submit
  end

  def comment
    self.comment_display[/^Your comments: (.*)/, 1]
  end
end



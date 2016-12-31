class GuineaPigPage < SitePrism::Page

  element :comment_input, "#comments"
  element :comment_display, "#your_comments"
  element :submit, "#submit"
  element :a_link, "#i_am_a_link"

  set_url "https://saucelabs-sample-test-frameworks.github.io/training-test-page/"

  def follow_link
    a_link.click
  end

  def on_page?
    has_a_link?
  end

  def submit_comment(comment)
    comment_input.set comment
    submit.click
  end

  def comment
    comment_display.text[/^Your comments: (.*)/, 1]
  end
end



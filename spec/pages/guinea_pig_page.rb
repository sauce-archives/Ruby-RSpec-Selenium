class GuineaPigPage < WatirDrops::PageObject

  page_url { "https://saucelabs-sample-test-frameworks.github.io/training-test-page/" }

  element(:comment_input) { browser.textarea(id: 'comments') }
  element(:comment_display) { browser.span(id: 'your_comments') }
  element(:submit) { browser.button(id: 'submit') }
  element(:a_link) { browser.link(id: 'i_am_a_link') }

  def follow_link
    a_link.click
  end

  def on_page?
    a_link.exists?
  end

  def submit_comment(data)
    fill_form(data)
    submit.click
  end

  def comment
    comment_display.text[/^Your comments: (.*)/, 1]
  end
end



module ApplicationHelper

  def markdown text
    render_options = {
      filter_html: false,
      hard_wrap: true,
    }
    renderer = Redcarpet::Render::HTML.new(render_options)

    extensions = {
      autolink: true,
      no_intra_emphasis: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end
end

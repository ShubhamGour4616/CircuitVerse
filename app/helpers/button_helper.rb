# frozen_string_literal: true

module ButtonHelper
  def render_button(text, link: nil, type: "button", **options)
    if link
      render_link(text, link, options)
    else
      render_button_tag(text, type, options)
    end
  end

  private

  def render_link(text, link, options)
    render(ButtonComponent.new(text: text, link: link, **options))
  end

  def render_button_tag(text, type, options)
    button_tag(text, options.merge(type: type))
  end
end

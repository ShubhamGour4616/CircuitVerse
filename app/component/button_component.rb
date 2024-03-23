# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  def initialize(text:, link: nil, **options)
    super
    @text = text
    @link = link
    @options = options
  end

  def button_or_link
    if @link
      link_to(@text, @link, link_options)
    else
      tag.button(@text, @options)
    end
  end

  private

  def link_options
    { class: button_classes }.merge(@options.except(:class))
  end

  def button_classes
    "btn #{@options[:class]}"
  end
end

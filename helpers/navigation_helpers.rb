require 'nokogiri'

module NavigationHelpers

  def get_nodes(file)
    page = Nokogiri::HTML(File.open("source/#{file}"))
    page.css('h2, h3')
  end

  def get_outline(file)
    outline = []
    last_headline = nil
    get_nodes(file).map { |h|
      { type: h.name, id: h['id'], title: h.text, children: [] } if !h.text.blank?
    }.compact.delete_if { |h|
      case h[:type]
      when "h2"
        outline << h
        last_headline = h
        false
      when "h3"
        last_headline[:children] << h
        true
      end
    }
  end

  def link_tree(outline)
    return if outline.empty?

    content_tag :ul do
      item_content = ''
      outline.each do |link|
        item_content << content_tag(:li) do
          link_content = ''
          link_content << link_to(link[:title], "/##{link[:id]}")
          link_content << link_tree(link[:children]) if !link[:children].empty?
          link_content.html_safe
        end
      end
      item_content.html_safe
    end
  end
end

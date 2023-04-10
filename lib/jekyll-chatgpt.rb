# frozen_string_literal: true

require_relative "jekyll-chatgpt/version"
require "liquid"

module JekyllChatgpt
  class Error < StandardError; end

  # Filter to transform ChatGPT data into HTML/CSS viewer
  module Filter
    def chatgpt(input, markdownify = true)
      site = @context.registers[:site]
      @context["conversation"] = input
      @context["mdfy"] = markdownify

      inclusion = site.liquid_renderer.file("chatgpt.html")
      inclusion.parse(File.read(File.expand_path("chatgpt.html", __dir__)))

      site.includes_load_paths.push(__dir__)
      res = inclusion.render(@context)
      site.includes_load_paths.pop

      res
    end
  end

  # Renders chatgpt.sass to /chatgpt.css
  class StyleGenerator < Jekyll::Generator
    safe true
    priority :lowest

    def generate(site)
      chatgpt_style = Jekyll::PageWithoutAFile.new(site, __dir__, "", "chatgpt.sass")
      chatgpt_style.tap do |file|
        colors_exists = site.pages.filter do |page|
          page.name =~ /colors\.sass$/i
        end.size
        file.content = ""
        file.content += "@import \"colors\"\n" if colors_exists
        file.content += File.read(File.expand_path("chatgpt.sass", __dir__))
      end
      site.pages << chatgpt_style
    end
  end
end

Liquid::Template.register_filter(JekyllChatgpt::Filter)

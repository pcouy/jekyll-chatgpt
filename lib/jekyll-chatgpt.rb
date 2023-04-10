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
end

Liquid::Template.register_filter(JekyllChatgpt::Filter)

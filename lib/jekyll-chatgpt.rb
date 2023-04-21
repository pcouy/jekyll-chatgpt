# frozen_string_literal: true

require_relative "jekyll-chatgpt/version"
require "liquid"
require "jekyll"
require "jekyll/converters/scss"

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

  # Renders nested `label` tags to display a message deep inside a branching
  # conversation
  class MessageLabel < Liquid::For
    def render(context)
      message_id_short = @variable_name
      conversation = context.evaluate(@collection_name)
      messages = conversation["mapping"]
      message_id = messages.keys.filter do |id_candidate|
        id_candidate.start_with? message_id_short
      end.first
      message_path = [message_id]
      message = messages[message_id]
      while message
        message = messages[message["parent"]]
        message_path.append(message["id"]) if message
      end
      res = "<a class=\"chatgpt-target\" href=\"\##{message_id}\">"
      res += message_path.map do |path_id|
        "<label class=\"chatgpt-deep-label\" for=\"chatgpt-control-#{path_id}\">"
      end.join("")
      res += @for_block.render(context)
      res += message_path.map { |_| "</label>" }.join("")
      res += "</a>"
      res
    end
  end

  # Renders needed styles and JS
  class StyleGenerator < Jekyll::Generator
    safe true
    priority :highest

    def sass_converter(site)
      @sass_converter ||= Jekyll::Converters::Sass.new(site.config)
    end

    def sass_exists(site, file)
      sass_converter(site).sass_load_paths.each do |dir|
        return true unless Dir.new(dir).children.index(file).nil?
      end
      false
    end

    def colors_exists?(site)
      sass_exists(site, "_colors.sass")
    end

    def add_js(site)
      message_label_js = Jekyll::StaticFile.new(site, __dir__, "", "chatgpt_message_label.js")
      site.static_files << message_label_js
    end

    def generate(site)
      chatgpt_style = Jekyll::PageWithoutAFile.new(site, __dir__, "", "chatgpt.sass")
      chatgpt_style.tap do |file|
        file.content = ""
        file.content += "@import \"colors\"\n\n" if colors_exists?(site)
        file.content += File.read(File.expand_path("chatgpt.sass", __dir__))
      end
      site.pages << chatgpt_style

      add_js(site)
    end
  end
end

Liquid::Template.register_filter(JekyllChatgpt::Filter)
Liquid::Template.register_tag("chatgpt_message_label", JekyllChatgpt::MessageLabel)

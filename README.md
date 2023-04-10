# JekyllChatgpt

This plugin inctroduces a `chatgpt` Liquid filter that formats ChatGPT conversations. It only uses CSS to navigate in branching conversations. A [live demo of deploying the demo branch of this repository to Github pages is available](https://pierre-couy.dev/jekyll-chatgpt)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add jekyll-chatgpt

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install jekyll-chatgpt

Optionally, include a stylesheet for code syntax highlighting in ChatGPT output. If you already have a code highlighting theme set up for your site, it should automatically be used.

## Usage

### Including a conversation

1. Download a conversation from [your ChatGPT history](https://chat.openai.com/). When on the ChatGPT web page, open your browser dev-tools (usually using F12) and go to the "Network" tab. Now, pick a conversation in the web-app. The URL in your browser should now look like `chat.openapi.com/chat/{some-random-looking-id}`. In the network tab of the developer tools, find the request to `{some-random-looking-id}` and right-click on it and pick "Copy > Copy response". You can now paste what you just copied into a JSON file inside your `_data` folder (for instance, `_data/chatgpt/test_conversation.json`).
2. You can now use `{{ site.data.chatgpt['test_conversation'] | chatgpt }}` anywhere in your liquid-rendered content to include the conversation in your website. This will render markdown in messages by default. You can disable markdown rendering by passing the `false` argument to the filter : `{{ site.data.chatgpt['test_conversation'] | chatgpt: false }}`.

### Customizing the colors

The necessary styles will automatically be inlined when using the filter. You can override the default colors by providing the following variables in your `_sass/_colors.sass` file : `$color1`, `$color1-alt`, `$color2`, `$color2-alt`, `$cyan`

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jekyll_chatgpt.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

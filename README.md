# JekyllChatgpt

This plugin inctroduces a `chatgpt` Liquid filter that formats ChatGPT conversations. It mostly uses CSS to navigate in branching conversations (except for links to specific messages inside a conversation, see "Usage" below). A [live demo of deploying the demo branch of this repository to Github pages is available](https://pierre-couy.dev/jekyll-chatgpt) ([code](https://github.com/pcouy/jekyll-chatgpt/tree/demo))

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add jekyll-chatgpt

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install jekyll-chatgpt

After installing, don't forget to update your `_config.yml` to include the plugin :

```yaml
plugins:   [other-plugins, jekyll-picture-tag-ng]
```

Optionally, include a stylesheet for code syntax highlighting in ChatGPT output. If you already have a code highlighting theme set up for your site, it should automatically be used.

## Usage

### Including a conversation

1. Download a conversation from [your ChatGPT history](https://chat.openai.com/). When on the ChatGPT web page, open your browser dev-tools (usually using F12) and go to the "Network" tab. Now, pick a conversation in the web-app. The URL in your browser should now look like `chat.openapi.com/chat/{some-random-looking-id}`. In the network tab of the developer tools, find the request to `{some-random-looking-id}` and right-click on it and pick "Copy > Copy response". You can now paste what you just copied into a JSON file inside your `_data` folder (for instance, `_data/chatgpt/test_conversation.json`).
2. You can now use `{{ site.data.chatgpt['test_conversation'] | chatgpt }}` anywhere in your liquid-rendered content to include the conversation in your website. This will render markdown in messages by default. You can disable markdown rendering by passing the `false` argument to the filter : `{{ site.data.chatgpt['test_conversation'] | chatgpt: false }}`.
3. You will be able to link to specific messages in conversations by using the `chatgpt_message_lagel` tag in the following way : `{% chatgpt_message_label [MESSAGE_ID] in [CONVERSATION] %}[LABEL_TEXT]{% endchatgpt_message_label %}` where `[MESSAGE_ID]` is the start of a message id ; `[CONVERSATION]` is the variable representing a conversation ; `[LABEL_TEXT]` is the displayed link text. Here is an example from [the demo page](https://pierre-couy.dev/jekyll-chatgpt) : `{% chatgpt_message_label 55bb5 in site.data.chatgpt["date"] %}a message{% endchatgpt_message_label %}`. This functionality uses Javascript, if you want to use it you must add the following tag to your `<head>` : `<script defer src="/chatgpt_message_label.js"></script>` (the JS file is automatically written to your website's output directory)

### Customizing the colors

The necessary styles will automatically be inlined when using the filter. You can override the default colors by providing the following variables in your `_sass/_colors.sass` file : `$color1`, `$color1-alt`, `$color2`, `$color2-alt`, `$cyan`

### Customizing the SASS/CSS

You can put your custom SASS inside `_sass/_chatgpt_custom.sass`. If the file exists, it will be imported and the properties set in your custom stylesheet will take precedence by using [CSS layers](https://developer.mozilla.org/en-US/docs/Web/CSS/@layer). The demo uses this to add rounded borders to the controls.

### Live demo

You can browse the [code for the live demo](https://github.com/pcouy/jekyll-chatgpt/tree/demo) which is intended to be a minimal example of using the plugin.

## Development

After cloning the repo, you can run the following commands in a local jekyll website's folder to start hacking on the code of `jekyll-chatgpt` (you'll need to replace the path in the second command :

    $ bundle remove jekyll-chatgpt # if you previously used jekyll-chatgpt from rubygems
    $ bundle add --path /absolute/or/relative/path/to/your/local/jekyll-chatgpt/repo jekyll-chatgpt
    $ bundle exec jekyll serve # Re-run this when you want to test changes to your local jekyll-chatgpt

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pcouy/jekyll-chatgpt.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

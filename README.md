# Jekyll ChatGPT

This repository contains a minimal working example for including ChatGPT conversations inside a Jekyll static website. A [live demo of deploying this repository to Github pages is available](https://pierre-couy.dev/jekyll-chatgpt)

## Features

- Display and navigate inside branching conversations (when you edit your own input or make ChatGTP re-generate its output) by including the JSON from OpenAI API as a data file
- Pure CSS controls : no javascript required (tested in Chromium and Firefox)
- Render markdown messages, or disable markdown rendering

## How to use ?

### Initial setup

1. Include the content of the `_plugins` directory into your own `_plugins` directory.
2. Include the `chatgpt.sass` file at the root of your website. The liquid filter will include it once per-page when needed. Note that this sass file imports `_sass/_colors.sass` for theming.
3. The [`solarized-light.css` file](https://gist.github.com/nicolashery/5765395) is a standard Jekyll code snippet highlighting theme. If you already have a code highlighting theme set up for your site, it should automatically be used .

### Including a conversation

1. Download a conversation from [your ChatGPT history](https://chat.openai.com/). When on the ChatGPT web page, open your browser dev-tools (usually using F12) and go to the "Network" tab. Now, pick a conversation in the web-app. The URL in your browser should now look like `chat.openapi.com/chat/{some-random-looking-id}`. In the network tab of the developer tools, find the request to `{some-random-looking-id}` and right-click on it and pick "Copy > Copy response". You can now paste what you just copied into a JSON file inside your `_data` folder (for instance, `_data/chatgpt/test_conversation.json`).
2. You can now use `{{ site.data.chatgpt['test_conversation'] | chatgpt }}` anywhere in your liquid-rendered content to include the conversation in your website. This will render markdown in messages by default. You can disable markdown rendering by passing the `false` argument to the filter : `{{ site.data.chatgpt['test_conversation'] | chatgpt: false }}`.

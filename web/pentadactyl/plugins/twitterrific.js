/*global buffer group */
group.commands.add(['tweet'],
  'Send URL to Twitterrific',
  function(args) {
    document.location = 'twitterrific:///post?message=' + window.escape(buffer.URL);
}, {argCount: 0});

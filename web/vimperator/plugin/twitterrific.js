/*global buffer commands */

commands.addUserCommand(['tweet'],
  'Send URL to Twitterrific',
  function(args) {
    document.location = 'twitterrific:///post?message=' + window.escape(buffer.URL);
});

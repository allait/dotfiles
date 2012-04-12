/*global dactyl buffer group */

group.commands.add(['py'],
  'Search python docs',
  function(args) {
    var base = 'http://docs.python.org/2.7/';
    var direct_url = base + 'library/' + args.join(' ') + '.html';
    var open_args = {"where": dactyl.NEW_TAB};

    var request = new XMLHttpRequest();
    request.open("HEAD", direct_url);

    request.onload = function() {
      if ((request.status >= 200 && request.status < 300) || request.status === 304) {
        dactyl.open(direct_url, open_args);
      } else {
        dactyl.open(base + '/search.html?q=' + args.join(' '), open_args);
      }
    };
    request.onerror = function() {
      dactyl.open(base + '/search.html?q=' + args.join(' '), open_args);
    };
    request.send(null);
}, {});

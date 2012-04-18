var search_engines = [
  {
    key: "clj",
    title: 'ClojureDocs',
    url:'http://clojuredocs.org/search?q=%s'
  },
  {
    key: "mdn",
    title: 'Mozilla Developer Network',
    url:'https://developer.mozilla.org/en-US/search?q=%s'
  },
  {
    key: "so",
    title: "Stack Overflow",
    url: "http://stackoverflow.com/search?q=%s"
  },
  {
    key: "gh",
    title: "GitHub",
    url: "https://github.com/search?q=%s"
  },
  {
    key: "dj",
    title: "Django Docs",
    url: "https://docs.djangoproject.com/search/?q=%s"
  },
];

/*global dactyl */

for (var i=0; i < search_engines.length; i++) {
  dactyl.execute('silent bmark -title "' + search_engines[i].title + '" -keyword ' + search_engines[i].key + ' ' + search_engines[i].url);
}

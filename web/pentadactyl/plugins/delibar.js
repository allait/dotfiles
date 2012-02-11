/*global buffer group */
group.commands.add(['deli[bar]'],
  'Bookmark page with Delibar',
  function(args) {
    document.location = 'Delibar://bpost' + '&!p!&' + buffer.URL + '&!p!&' + buffer.title + '&!p!&' + buffer.selection;
}, {argCount: 0});

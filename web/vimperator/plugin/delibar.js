/*global buffer Ci commands */

commands.addUserCommand(['deli[bar]'],
  'Bookmark page with Delibar',
  function(args) {
    var selection = buffer.selectionController.getSelection(Ci.nsISelectionController.SELECTION_NORMAL).toString();
    document.location = 'Delibar://bpost' + '&!p!&' + buffer.URL + '&!p!&' + buffer.title + '&!p!&' + selection;
}, {argCount: 0});

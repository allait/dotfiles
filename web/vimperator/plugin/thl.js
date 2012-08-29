/*global buffer Ci commands */

commands.addUserCommand(['thl'],
  'Add task to The Hit List',
  function(args) {
    var taskTitle = '';
    var url = buffer.URL;
    var selection = buffer.selectionController.getSelection(Ci.nsISelectionController.SELECTION_NORMAL).toString();
    if (selection) {
      taskTitle = selection;
    }
    else {
      taskTitle = "Look at \"" + buffer.title + "\"";
    }

    document.location = "thehitlist:///inbox/tasks?method=POST&title=" + encodeURIComponent(taskTitle) + "&url=" + encodeURIComponent(url);
});

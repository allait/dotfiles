/*global buffer group */
group.commands.add(['thl'],
  'Add task to The Hit List',
  function(args) {
    var taskTitle = '';
    var url = buffer.URL;
    if (buffer.selection.toString()) {
      taskTitle = buffer.selection;
    }
    else {
      taskTitle = "Look at \"" + buffer.title + "\"";
    }
    document.location = "thehitlist:///inbox/tasks?method=POST&title=" + encodeURIComponent(taskTitle) + "&url=" + encodeURIComponent(url);
}, {argCount: 0});

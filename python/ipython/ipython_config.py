# Configuration file for ipython.

c = get_config()


# Import modules at IPython startup.
c.InteractiveShellApp.exec_lines = [
    'import os',
    'import sys'
]

# Whether to display a banner upon starting IPython.
c.TerminalIPythonApp.display_banner = False

# Set to confirm when you try to exit IPython with an EOF
c.TerminalInteractiveShell.confirm_exit = False

# Enable completion on elements of lists, results of function calls,
# etc., but can be unsafe because the code is actually evaluated on TAB.
c.IPCompleter.greedy = False

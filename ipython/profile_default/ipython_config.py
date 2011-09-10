# Configuration file for ipython.

c = get_config()

# List of files to run at IPython startup.
c.InteractiveShellApp.exec_files = [
    "virtualenv.py",
]

# List of commands to execute at IPython startup.
c.InteractiveShellApp.exec_lines = [
    'import os',
    'import sys',
]

# Whether to display a banner upon starting IPython.
c.InteractiveShellApp.display_banner = False

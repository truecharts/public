# Setting up your dev environment

With TrueCharts we use some custom tools to make sure you have the least amount of work possible when working on the project.
However, this means you need some custom tools before you can start working on TrueCharts:

- Git (git client optional)
- Python (including Pip, added to path on windows)
- Pre-Commit (prefered)

## Windows

### Terminal basics:
When we talk about "In a terminal" we mean doing the following:
- hit windows+r
- enter "cmd"

### GIT

- Download and install GIT (https://git-scm.com/download/win)
- Most default options would be fine

In a terminal window or GUI client:
- Clone the repository in a specific directory of your choice (we will call this "Project-Root")


### Python
- Install Python3 with the installer (https://www.python.org/downloads/)
- Right click "Run as administrator"
- Check "Add to Path"
- Click the big install button

### Pre-Commit
Run .tools/pre-commit-install.bat
(Advanced users: This is for beginner users and will also execute "git config --unset-all core.hooksPath")
OR
In a terminal window:
- Enter "pip install pre-commit"
- CD to Project-Root
- Enter "pre-commit install"

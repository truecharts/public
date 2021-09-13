# Command Cheatsheet

These are some commands that are nice to keep track of:

**give execute permissions to all sh files:**
`find . -name '*.sh' | xargs git update-index --chmod=+x`


**list all used repositories in the catalog:**
`find . -name 'values.yaml' | xargs cat | grep "repository" | grep -v "{" | awk -F":" '{ print $2 }' | grep -v '^$' | sort --unique`

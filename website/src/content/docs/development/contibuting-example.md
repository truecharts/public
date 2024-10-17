---
title: Contribution Guide
---

Git, GitHub, and other tooling utilized by the TrueCharts repository can be intimating if you've never used them before. In order to encourage
contributions from the community, this guide acts as a start-to-finish practical example of contributing content to TrueCharts, and incidentally
a crash course in using Git.

Due to the massive breadth of these topics, this guide only cover what's necessary to make a basic change in order to remain as concise and digestible
as possible. The concepts covered here will need to be explored in greater depth when making more complex changes. It's highly suggested that in the
long run you better familiarize yourself with each aspect of Git that is touched on, but it's of course easier to learn more when you have something
to get started with.

With the above goal in mind, this example will walk you through adding documentation to an existing chart. The process of actually composing a helm
chart is **not** covered here, though will you need to understand the following procedure if you are to later contribute chart code.

## Guide

---

:::note

You will need a [GitHub](https://github.com/login) account if you don't already have one.

:::

It's a good idea to familiarize yourself with the [Contribution Guidelines](/development/contributing/) before/after reading this guide, but definitely
before you actually make a pull request.

### Create a Fork

The first step to contributing is to [fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo)
the TrueCharts repository. A fork is like your own copy of the repository that can be modified without affecting the original.
You only need to do this once, as the fork can be re-used for all changes you wish to make.

To create a fork, navigate to the [truecharts/charts repository](https://github.com/truecharts/charts/fork) and press the
Fork button in the upper-right corner.

![fork-example](/img/CE/1_Fork.png)

On the following page, leave all of the default settings and click **Create Fork**. After a moment, you will presented with the main page of your fork,
which is where you will first enact any changes that you wish to be added to the original repository.

Note that in this situation the original repository is often referred to as the _upstream repository_, or simply _upstream_, whereas your fork of the
repository is referred to as the _downstream repository_ or _downstream_.

### The Git Workspace

The traditional way to use Git is to install a copy of it on your system and work with it locally; however,
in order to keep things simple and convenient we are going to use Codespaces, a feature of GitHub that
allows you to work on the repository with a variety of editors directly from your browser.
You can still use a traditional copy of Git if you'd like, and it's recommended to do so long term,
but for now this guide will assume you're using Codespaces.

1. Click the green **Code** button on your fork's page
2. Switch to the **Codespaces** tab
3. Click the **Create Codespace on master** button
4. Wait until the codespace has been created (this can take some time due to the size of the repository)

Just like with the fork itself, you only need to make a codespace once.

Once the codespace has fully loaded, you should close the default tabs present within the editor and the notifications in the
lower right corner as none of them are relevant for work we will be doing.

Afterwards, it should look something like this:

![Codespace-example](/img/CE/2_Codespace.png)

While editing the repository, you may get more notifications in the lower right about features potentially not working due to missing components,
as Codespaces tries to automatically detect which components may be useful to you depending on what files you open. These can simply be ignored and closed.

### Git Preface

Git can be interacted with with via the editor's UI, but we're going to use git entirely through its CLI via the terminal.
Believe it or not this can sometimes be simpler. Also, it's universal as use of Git in this fashion is always the same regardless
of your platform and environment, whereas every editor integrates git differently.

All Git commands begin with the word `git`

:::note

You can add the `--help` switch after any git command in order to view further information about said command.

    ```bash
    git commit --help
    ```

Be aware that the official Git manual is highly detailed and technical. If you're stuck on a particular part, it may be easier to get help elsewhere.
As always Google is your friend.

:::

### Create a Topic Branch

Branches are one of the ways that code is organized and tracked within Git. You can switch between branches at any time, though for the purposes of
this guide they will not need to be used extensively. When creating a change intended for the original repository, it's best to author this change within
a topic branch, which is just what it sounds like: A branch dedicated to a specific topic, in this case our documentation change.

**For TrueCharts specifically you should always create your topic branch off of the master branch.** Your workspace will be on the `master` branch by
default, so you don't need to worry about this at first, but it's important to remember this when re-using a codespace for future changes. To get back
to the master branch at any time use the `checkout` command like so:

    ```bash
    git checkout master
    ```

As for the topic branch to be created, this guide will pretend to add Installation Notes to the librespeed chart, so we will use the branch name
`librespeed_inst_notes`. Try to keep branch names fairly terse, and of course use one that's appropriate for the change you're actually making.
To create this branch and switch to it simultaneously:

    ```bash
    git checkout -b librespeed_inst_notes
    ```

At this point, you can make the actual changes desired.

### Adding installation notes

In the Explorer window on the left is the repository's hierarchy.
Since we wish to add documentation to a chart we must navigate to the chart's specific folder, which is librespeed in this case.

Navigate to `charts/stable/librespeed`. If the chart in question doesn't have a `docs` sub-folder already you will need to create one by via the
right-click context menu. Finally, create the file `installation_notes.md` within the docs folder. In the end there should be

    charts/stable/librespeed/docs/installation_notes.md

which you should open in the editor.

#### Markdown

Within this file is where you will write notes on how to install the chart.
These notes, along with most other documentation for the TrueCharts project is written in [Markdown](https://www.markdownguide.org/basic-syntax/).
Discussion on Markdown can become somewhat complex, but basic usage is straight forward. Markdown documents are composed more-or-less like regular
documents, but with some special syntax that dictates formatting, which can be seen in the above link.

The best way to get a sense of how you should compose your notes is to look at the markdown for another chart that
already has an `installation_notes.md` file.

For this example, we're placing the following into the notes file we just created:

    ```markdown
    # Librespeed Installation Notes

    ## General

    This chart does not need any special steps to be installed and can be installed normally, following the general guideliness for TrueCharts charts.
    This file exists only as an example.

    ## Web Portal

    Don't forget to enable ingress if you want to access the speed test portal via a domain name!
    ```

:::note

These notes are just for demonstration purposes and obviously are not actually useful for TC users.
Please make sure that the documentation you're adding is warranted and as helpful and well-written as possible.

:::

Once finished making your actual changes to the repository (be sure to save them, though Workspaces auto-saves quite frequently),
we can now work on submitting them upstream.

:::caution

If you are updating more than just documentation, you will also need to "bump" (increase) the version of the chart, present in its `chart.yml` file.

:::

### Create a commit

Commits in git are set of like changes encapsulated as a single node on a given branch. All changes within a git repository are not finalized until
they are recorded via a commit. This allows one to easily view the history of a repository in sensible chunks and see step-by-step what changes were
made to the repository over time.

Exactly what changes should go into a single commit, and how many commits you should split a group of changes into is sometimes a grey area and subjective.
Generally, you should try to make sure that each commit only contains changes to files that are **directly** related to one another. Don't include a
change that alters a chart's icon within the same commit as a change that fixes a bug in the chart. For example, if you were making a functional
change to a chart besides just documentation, you should probably bump the charts version in a separate commit.

A good guideline for this is the concept of [atomic commits](https://dev.to/samuelfaure/how-atomic-git-commits-dramatically-increased-my-productivity-and-will-increase-yours-too-4a84#:~:text=What%27s%20an%20atomic%20git%20commit).

For this particular example, we are only changing one file, and in a way that is entirely self-related (notes for installation) so one commit is fine.

#### Staging Files

Before a commit can be created, the files that are to be a part of that commit must be staged, which can more-or-less be thought of as just marking
which files will be in the commit.

    ```bash
    git add --all
    ```

This will stage **all** the files within the repository that you've modified, which in this case is fine since we've only changed one file.
Just know that if you've changed multiple files but don't want all of them in the commit you will need to explicitly write out the paths
to the files you want to stage after `git add` instead of using `--all`.

You can ask for a status check to ensure the appropriate file has been staged after the fact:

    ```bash
    git status
    ```

#### Making the commit

Now its time to commit to your changes (get it?). Simply do the following:

    ```bash
    git commit
    ```

This will open a new text file in the editor where you will need to write a commit message...

#### Commit message

Writing good commit messages for complex changes is an artform, but for very simple ones like this it's straightforward.

Your commit message contains two sections:

- Summary
- Body

The summary of the message is the first sentence of the commit and gives a brief overview of the changes. Try to keep it short.

:::caution

A commit message should be 72 characters wide or less. In other words, use a line break every time you'd exceed that many characters.

The summary should be 72 characters or less **period**.

:::

The body of the message follows the summary and must be separated by two line-breaks (e.g. so that there's an empty line between them).
Details about the commit are to be contained in the body, often with a rationale behind the changes. The _why_ is just as important as the _what_;
however, for very simple and largely self-explanatory commits like our example, a body isn't even necessary.

A final note is that generally you want to write commit messages in the [present tense and imperative mood](https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/SubmittingPatches?h=v2.36.1#n181)
(i.e. somewhat like you're stating a command). For this example, the following is a good commit message:

    Add installation notes to librespeed

For future reference, when making commits with simple messages like this you can save time by entering them directly on the command line like so:

    ```bash
    git commit -m "Message here"
    ```

Once finished, save the file and then close its tab in the editor, this will complete the commit with the supplied message.

### Push the commit to the remote repository

This step requires a brief explanation of how Git repositories are typical managed in this context. In this situation there are actually three copies
of the same repository. The terms for these can vary, but generally there is:

1. (local) The copy of the repository on your local system where you are actually working. Here, this is slightly confusing since you're using
2. GitHub Workspaces which is in the cloud, but it still must be thought of as a "local" system.
3. (origin/remote) The copy of your fork on GitHub itself. This is what you can see/browse when you go to your fork's URL in your browser.
4. (upstream) This is the original TrueCharts repository from which you initially created a fork.

:::note

These terms are relative, and can mean different things in different contexts. For example, when the focus of a conversation in on TrueCharts itself.
"Upstream repository" might refer to the repo for one of the projects that TrueCharts maintains charts for (e.g. plex, jellyfin, immich, etc.)

The associations listed here are specific to the context of the situation presented in this tutorial.

:::

Right now the commit we've made is only in the local copy of the repository and we need to get it upstream, which first requires getting it to the origin.
This is done with the `push` command, which updates the version of your current branch on the origin repository with new commits from the same branch
in your local copy; however, in this case since the `librespeed_inst_notes` branch also currently only exists in our local repository we need to create
the branch on the origin as well. Git provides a shortcut for pushing changes on a new branch to the remote repo in one step:

    ```bash
    git push --set-upstream origin librespeed_inst_notes
    ```

You will now notice that your fork on GitHub also has the new branch, along with the commit we just made.

The Workspaces session is no longer needed and can be closed.

### Make a Pull Request

The final step to integrating your changes is to submit a PR (pull request) to the upstream repository. This is a formal request for the upstream
(e.g. TrueCharts) to review your changes and "pull" them into their repository should they be accepted.

To do so, navigate to the main page of the upstream repository on [GitHub](https://github.com/truecharts/charts). Here, if it hasn't been too long
since you pushed to your remote, you will notice a convenient button for creating a PR based on your topic branch presented to you by GitHub.
But just in-case it's not there, this guide will ignore it and demonstrate the slightly longer way.

![PR-example](/img/CE/3_PR.png)

1. Click the **Pull requests** tab at the top left of the repo.
2. Click the green **New pull request** button near the top left of the next page
3. Click the blue text that says **compare across forks** under the "Compare changes" heading
4. Leave the left side boxes on `truecharts/charts` and `master`
5. Set the right side `head repository` to your fork, i.e. `github_username/charts`
6. Set the right side `compare` to your topic branch, i.e. `librespeed_inst_notes`
7. Click the green **Create pull request** button

Here you will enter the title of the PR and fill details related to it. If your PR contains only one commit, the PR title should automatically have
been set to that commit's summary, which is often a reasonable PR title. **Fill out the PR template in the details section as appropriate.**

Finally, being sure to leave the "Allow edits by maintainers" checkbox checked, hit **Create pull request** to submit the PR.

### Next Steps

Assuming all is well and your changes are deemed desirable, they will be reviewed and then merged into the upstream repository. At that point, your
work is done and you can delete the topic branch on your fork if you wish.

#### Making changes

If the project maintainers request changes, you must re-open your GitHub workspace (which will have a randomly generated goofy name) to make the changes.
As a general rule of thumb in git, **do not alter existing commits and instead make alterations by creating new ones**; _however_, creating PRs via a
topic branch is one of the exceptions in which not only is it appropriate to modify previous commits, but often preferred.

Once back in your workspace, make the required changes to your documentation file and then stage them as before.

    ```bash
    git add --all
    ```

This time however, instead of making a new commit we are going to update the one we made before.

    ```bash
    git commit --amend --no-edit
    ```

`--no-edit` tells git to keep the previous commit message as is. If you need to edit the message too, do not include that switch.

Finally, push the changes to the origin repo while also acknowledging to git that you are overwriting past changes

    ```bash
    git push --force-with-lease
    ```

Forcing a push like this is known as "rewriting history" and is not something that should be done lightly, but this is one of the cases where it is appropriate.

Once your origin repository is updated the changes will also automatically be reflected within the pull request. Repeat this process as needed until
the PR satisfies project maintainers.

:::note

Revising more than one commit is more complicated and out of the scope of this guide. Remember, you can always play things safe by just creating new
commits with your edits instead of amending past ones.

:::

#### Future changes

When preparing to submit a subsequent PR there are two important things to remember.

First, you will always want to **re-sync** your fork's master branch with the upstream's master branch so that you are working off of the latest state
of TrueCharts, as by default your fork will remain in whichever state you last left it.

To do this, navigate to your fork's homepage on GitHub. While being sure that the branch drop-down is set to **master** select the **Sync fork** option
and hit the green **Update branch** button.

![Sync-example](/img/CE/4_Sync.png)

Second, when returning to your codespace you'll notice that it's still on the topic branch you created before (if you haven't deleted it yet). You can
either create a new codespace on the master branch, or open that codespace and return to the master branch by using the command shared previously:

    ```bash
    git checkout master
    ```

From here you can start work on your next PR.

## TODO

---

- Include tips for handling rebasing to account for upstream changes by maintainers
- Include tips for handling merge-conflicts
- Add more pictures
- Note how to add images to documentation
- Note how to add warning/note blocks

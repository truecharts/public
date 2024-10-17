---
title: Contribution Guidelines
---

This project welcomes any and all input, but we need to have a few quality guidelines. These guidelines will be explained here, in this document.

## GIT Guidelines

---

### New to GIT

If you have never used git before, you can look up our general reference on our wiki.

### Git and You

GIT is a fantastic system, but while using it we have a few guidelines to keep it fantastic for everyone.

- Submit complete PR's.
- Add [DNM] if you do not want your PR merged yet.
- Always try and fill in the whole form, even for small PR's.
- Don't close when a reviewer requests changes (just push the changes or ask for help).
- Explain what you did in your PR.
- Be thorough.
- If you can add screenshots to clarify.
- Always try to add "Fixes #000" (where 000 is the Issue your PR fixes)
- found something you want to fix yourself? Please do make an issue too.

## Structure Guidelines

---

### Inclusion of files and folders

Although GIT is quite friendly in what it accepts in terms of files and folder changes in a commit, a reviewer's or bug-fixer's time is not unlimited.
For that reason, we have a few specific guidelines in regards to the inclusion of files and folders in your PR.

- Only include files you actually changed.
- Try not to include multiple changes in one PR
- Want to change the formatting of multiple files too? Make a separate PR.

## Code Guidelines

---

### Your code, your style, my review

Here at TrueCharts, we value people having their own style. But your code needs to be reviewable and editable by others too.
For that reason, we have a few basic coding guidelines

- **Always** explain regex in a comment within your code.
- Write simple code and don't try to impress.
- We will run (Basic) automated reformating of code once in a while.
- Document your changes in your code and if need be, on the wiki.
- All PR's should be able to pass our automated tests.

#### Apps requirements

- Apps should always save user-specific data in a persistent location. That can be connected by both IXVolume or Hostpath
- Apps should not require the user to edit any config file themselves. All config changes should be either automated or using the UI
- Apps should not use default passwords, the user should always be forced(!) to put credentials in manually

## Review Guidelines

---

Even us review gods need some guidelines once in a while.

- Let people learn from their mistakes
- Review instead of merging without comments
- Abide by these guidelines in your review
- Tests exist for a reason. Don't merge with test-failures

## Todo vs Feature vs bug

---

Please take note of the difference between a TODO and Feature

- Bug: An unexpected behavior of the script or a crash. Including, but not limited to, errors and warnings.
- Todo: When you come across something that needs tweaking/adding during development, is not an unexpected behavior
- Feature: When you, out of personal preference, want something added or changed.

### That's it

---

Someone will come along and review the changes. If everything looks good then they will merge it with the main repo.
If you need any help don't be afraid to ask in the discord channel: [https://discord.gg/tFcTpBp](https://discord.gg/tFcTpBp)

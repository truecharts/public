---
title: Important Notes
---

The Firefly III developers have decided to split their program into multiple different add-on containers, implementing these ourselves into the App is EXTREMELY time-consuming. While we would appreciate people with experience building Helm Charts and adding the feature containers, we have decided to flag them "out of scope" for TrueCharts.

If you really want to use them, you can use `app-template`. However, we do not actively support such a setup.

## APP_KEY

Needs to be exactly 32 digits anf may contain Letters, Numbers and Symbols.
It accepts `a-z`, `A-Z`, `0-9` and `!@#$%^&*?`

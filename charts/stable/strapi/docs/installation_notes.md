---
title: Installation Notes
---

- Create a `Jwt Secret` to be used to signed the JWT for Users-Permissions plugin.
- Create a `Admin Jwt Secret` to be used to sign the JWT for the Admin panel.
- Set `App Keys` as a json array:
  - `['keya', 'keyb']`.
- Set `Node Environment` to **Development** initially.
- Optionally set `Public URL` to a FDQN with https, ex: `https://api.example.com`.
- Optionally set `Strapi License` to activate the premium Edition.
- Enable/Disable `Strapi Disable Update Notifications` for strapi update notifications.
- Enable/Disable `Fast Refresh` for react near-instant feedback.
- `Extra Args` can be left empty for the standard defaults or get args from [strapi-new](https://strapi.io/documentation/developer-docs/latest/developer-resources/cli/CLI.html#strapi-new).
- After the app is installed you might get a `Content Security Policy` error. To solve this you have to manually shell into the app.

  - Apps -> strapi -> 3 dot -> shell:
  - run the following command to build the admin panel for v4:

    ```shell
    npm run build
    ```

- Restart the app after the command is ran successfully.

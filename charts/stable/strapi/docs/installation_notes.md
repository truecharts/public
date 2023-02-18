# Installation Notes

- Set `Node Environment` to **Development** initially.
- After the app is installed you might get a `Content Security Policy` error. To solve this you have to manually shell into the app.

  - Apps -> strapi -> 3 dot -> shell
  - run the following command to build the admin panel for v4:

    ```shell
    npm run build
    ```

- Restart the app afterward the command is ran successfully.

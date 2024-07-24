---
title: Input Validation
---

## Admin Username

Usernames for an administrator in spotweb have some restrictions.

- Following words are not allowed:
  - god
  - mod
  - spot
  - admin
  - drazix
  - superuser
  - supervisor
  - root
  - anonymous
- Following characters are not allowed:
  - `<`
  - `\>`
- Regex used to validate the username (you can try live [here](https://regex101.com/r/LA4Io7/1)):
  `^((?!god|mod|spot|admin|drazix|superuser|supervisor|root|anonymous)[^<>])*$`

## Admin Firstname and Lastname

The firstname and lastname in spotweb have some restrictions.

- Following characters are not allowed:
  - `<`
  - `\>`
- Minimum lenght of 2 characters is enforced
- Regex used to validate the firstname and lastname (you can try live [here](https://regex101.com/r/x2KGnU/1)):
  `^([^<>]{2})([^<>]*)$`

## Admin Email

The email addres is validated in spotweb using the built-in `_FILTER_VALIDATE_EMAIL`.

- Regex used to validate the email (you can try live [here](https://regex101.com/r/yEmCoL/1)):

  ```shell
  ^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$
  ```

---

If you find a field that you think it needs validation, please open an issue on github

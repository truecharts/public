---
title: Signing Commits
---

Every commit in Git has the possibility of being signed with a cryptographic with asymmetric keys. Coplementary is possible to verify the integrity and the authorship of every signed commit.

This feature ensure that a specific commit is signed by the owner of a certain private key; it is possible to boundle the key pair with an identity like an email address through a *keyserver* or the GitHub account. The server will certify the identity to ensure the correspondence with the user.

If the keypair is boundle with the GitHub account all the commits in a PR are verified to be made from the owner of the GitHub account appearing as commit author. 
If a commit is verified on GitHub is showed a green tick mark with written *verified*.

<!-- TODO: add picture of the verified commit -->

To enanche the security of a repository all commit should be verified, but the procedure to generate the keys, add to GitHub and enable the signature require his guide on its own and the following should show how to sign every commit on the local fork of the repository.

## Guide

---

This guide show how to enable the signature by default on a specific repository using `gpg` command form the `gnupg` package provided by [GnuPG](https://www.gnupg.org/) and default algorithm for key generation.

### Generate a key pair

Check if you have the command `gpg` installed with `gpg --version` if error is returned you have to [install it](https://www.gnupg.org/download/index.html).

If you already used `gnupg` you could have some keys in you keyring. You can use `gpg -k` for listing the public keys in you keyring and `gpg -K` for the private ones.

:::note

You can specify the `--homedir <PATH>` option or set the variable `$GNUPGHOME` to point a keyring different from the default one (`~/.gnupg`)

:::

If you don't have any private key corresponding to your identity you can generate a pair of keys with
```bash
gpg --gen-key
```
:::note

If you want to choose other technical details of the keypair you can use the `--full-gen-key` option at the place of `--gen-key`.

:::

You have to specify your real name, an email address and a comment. Put your surname and family in the first field (or the name string with which you have to be identify), your email address, when you are satisfy save the key. It will ask for a passphrase to encrypt the private key, put a strong password and save in your password manager. The output after generating or listing the keys should be something like:
```bash
pub   ed25519 2025-02-17 [SC] [expires: 2028-02-17] 
      E24932D7A1C8946ADDBD2FC39C359CFF3DE6B58A 
uid                      Alice Smith <alicesmith@example.com>
sub   cv25519 2025-02-17 [E] [expires: 2028-02-17]
```
in this case the `<key-ID>` that idenfify the key pair is `E24932D7A1C8946ADDBD2FC39C359CFF3DE6B58A`.

You can delete the key with the command

```bash
gpg --delete-secret-and-public-key <key-ID>
```

### Sign a commit

You can set the key generated as your git signing key for all the repositories with:

```bash
git config --global user.signingkey <key-ID>
```

:::note

If you want use the key only for the current repository you can remove the `--global` option

:::

you can now sign a commit adding the `-S` option

```bash
git commit -S
```

to be sure that your commit is signed you can verify writing

```bash
git log --show-signature -1
```
the output should be something like:

```bash
commit 1ecabe02e88d89bc30aee8f8ba92939dae2b024e (HEAD -> master)
gpg: Signature made Mon 17 Feb 2025 03:16:06 PM CET
gpg:                using EDDSA key E24932D7A1C8946ADDBD2FC39C359CFF3DE6B58A
gpg: Good signature from "Alice Smith <alicesmith@example.com>" [ultimate]
Author: Alice Smith <alicesmith@otherexample.org>
Date:   Mon Feb 17 15:11:35 2025 +0100

    This is my first signed commit!
```

with the header indicating the signature.

:::note

If you want to sign your last commit after you already committed it you can do it recommiting it with the `-S` option and `--amend` to overwrite the last commit

:::

you can verify the signature of a commit with

```
git verify-commit <commit-hash>
```

:::warning

This verify that the author of the commit is the owner of the private key, not that the name, the email and the identity of the user is actually the one indicated in the key

:::

### Enable signing commits by default

You can enable signing of commits by default in the current repository with

```bash
git config commit.gpgsign true
```

:::note

If you want to enable the signature of the commits by default in all repositories you can add the option `--global`

:::


### Add the public key to GitHub account

Adding the public key to the GitHub accuont permits to guarantee that the owner of the account doing the commits is the same owner of the private gpg key.
To add the key you have to go in your [personal settings](https://github.com/settings/profile) (click on your account picture in the upper right corner, and than into *settings*), than enter in the ["*SSH and GPG keys*" section](https://github.com/settings/keys) under "*Access*" in the left menu. 
Click on "*New GPG key*" add a meaningful title to the personal key like "*Git singing key - laptop*" and copy the output of the 

```bash
gpg --export -a <key-ID>
```
command in the "*Key*" section.

<!-- TODO: add image adding key -->

Click "*Add GPG key*" to save. Now you key should show under the ["*SSH and GPG keys*" section](https://github.com/settings/keys)

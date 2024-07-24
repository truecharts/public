---
title: Adding or Removing Headers
---

The `customRequestHeaders` and `customResponseHeaders` middlewares will allow you to add or remove headers from the request or response.

## `customRequestHeaders`

You can specify a list of headers to add to requests. When removing a header, you only need to specify the header name (an empty value removes the header with that name from requests, if it exists).

## `customResponseHeaders`

You can specify a list of headers to add to responses. When removing a header, you only need to specify the header name (an empty value removes the header with that name from responses, if it exists).

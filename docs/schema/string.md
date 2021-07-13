## String Schema


#### Example of string schema options:
```
schema:
    type: string
    private: true
    min_length: 5
    max_length: 12
    valid_chars: "[a-zA-Z0-9]$"
```

Following attributes can be added to string schema to enforce validation when a chart release is being created/edited:

`min_length` is an integer field which adds validation to ensure value provided for this variable is at least the specified
characters.

`max_length` is an integer field which adds validation to ensure value provided for this variable is at max the specified
characters.

`private` is a boolean field which when set by chart maintainer, will result in the value of the variable not being
shown to the user in the UI. This is useful for sensitive fields like password where a dummy character is placed for
each character provided for this string in the UI.

`valid_chars` is a string field which chart maintainer can specify to provide a regex to enforce that the value provided
for the variable should conform to a pattern. TrueNAS Scale will use python3 regex (https://docs.python.org/3/library/re.html)
syntax to enforce `valid_chars`.

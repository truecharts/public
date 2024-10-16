import re
import os

# Path to the directory with Go files
directory = "."

# Updated regex pattern to find incorrect Msgf statements
pattern = re.compile(r'log\.Info\(\)\.Msgf\((\"[^\"]*\")((?:,\s*(?:\"[^\"]*\"|\w+))*)\)')

# Function to embed string literals and handle existing %s or %v placeholders
def replacer(match):
    message = match.group(1)
    args = match.group(2).strip().split(',')[1:]  # Extract arguments

    formatted_message = message[:-1]  # Remove the closing quote for now
    new_args = []
    placeholders = []

    # Count the number of existing %s and %v in the message
    existing_placeholders = re.findall(r'%[sv]', formatted_message)

    for arg in args:
        arg = arg.strip()
        if re.match(r'\"[^\"]*\"', arg):  # If the argument is a string literal
            formatted_message += " " + arg[1:-1]  # Embed the string literal without quotes
        else:  # If the argument is a variable
            # Determine which placeholder to use
            if "str" in arg.lower():  # Customize this check as needed
                placeholders.append('%s')
            else:
                placeholders.append('%v')

            new_args.append(arg)

    # Insert additional placeholders, only if we haven't exceeded existing placeholders
    for _ in range(len(placeholders)):
        if len(existing_placeholders) > 0:
            existing_placeholders.pop(0)  # Consume an existing placeholder
        else:
            formatted_message += " " + placeholders.pop(0)

    # Close the format string and reassemble the log statement
    formatted_message += '",'

    # Add any remaining arguments
    return f'log.Info().Msgf({formatted_message} {", ".join(new_args)})'

# Iterate over Go files and apply the regex replacement
for subdir, _, files in os.walk(directory):
    for file in files:
        if file.endswith(".go"):
            filepath = os.path.join(subdir, file)
            with open(filepath, 'r') as f:
                content = f.read()

            # Apply the replacement
            new_content = pattern.sub(replacer, content)

            # Write the modified content back to the file
            with open(filepath, 'w') as f:
                f.write(new_content)

print("Replacement completed!")

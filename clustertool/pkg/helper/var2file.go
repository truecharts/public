package helper

import (
    "errors"
    "os"

    "github.com/rs/zerolog/log"
)

func VarToFile(filename string, content string) error {
    if _, err := os.Stat(filename); err == nil {

    } else if errors.Is(err, os.ErrNotExist) {
        // Write the content to the file
        err := os.WriteFile(filename, []byte(content), 0644)
        if err != nil {
            log.Info().Msgf("Error writing to file: %v", err)
            return err
        }
    } else {

    }
    return nil

}

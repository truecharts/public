package utils

import (
    "io/ioutil"
    "log"
    "sync"

    "net/http"
    "my-proxy-service/internal/config"
    "github.com/fsnotify/fsnotify"
)

var mutex sync.Mutex

func ReadAuthToken() (string, error) {
    mutex.Lock()
    defer mutex.Unlock()

    content, err := ioutil.ReadFile(config.ApiFile)
    if err != nil {
        return "", err
    }
    return string(content), nil
}

func CopyHeaders(w http.ResponseWriter, resp *http.Response) {
    for key, values := range resp.Header {
        for _, value := range values {
            w.Header().Add(key, value)
        }
    }
}

func HandleError(w http.ResponseWriter, err error, code int) {
    log.Printf("Error: %v", err)
    http.Error(w, err.Error(), code)
}

func WatchFile() {
    watcher, err := fsnotify.NewWatcher()
    if err != nil {
        log.Fatalf("Error creating watcher: %v", err)
    }
    defer watcher.Close()

    err = watcher.Add(config.ApiFile)
    if err != nil {
        log.Fatalf("Error adding file to watcher: %v", err)
    }

    for {
        select {
        case event, ok := <-watcher.Events:
            if !ok {
                return
            }
            if event.Op&fsnotify.Write == fsnotify.Write {
                log.Println("File modified, updating authentication token...")
                if err := handleFileChange(config.ApiFile); err != nil {
                    log.Printf("Error updating authentication token: %v", err)
                }
            }
        case err, ok := <-watcher.Errors:
            if !ok {
                return
            }
            log.Println("Error watching file:", err)
        }
    }
}


func handleFileChange(filePath string) error {
    content, err := ioutil.ReadFile(filePath)
    if err != nil {
        return err
    }

    if len(content) == 0 {
        log.Println("Warning: Empty file content.")
        return nil
    }

    log.Println("Authentication token updated successfully.")
    return nil
}

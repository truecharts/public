package sops

import (
    "errors"
    "fmt"

    "github.com/getsops/sops/v3"
    "github.com/getsops/sops/v3/aes"
    "github.com/getsops/sops/v3/age"
    "github.com/getsops/sops/v3/cmd/sops/common"
    "github.com/getsops/sops/v3/cmd/sops/formats"
    "github.com/getsops/sops/v3/config"
    "github.com/getsops/sops/v3/decrypt"
    "github.com/getsops/sops/v3/keys"
    "github.com/getsops/sops/v3/keyservice"
    "github.com/getsops/sops/v3/version"
    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

var encrConfig *EncryptionConfig

const ageKeyFilePath = "./age.agekey"

func EncryptWithAgeKey(body []byte, regex string, format string) ([]byte, error) {
    log.Trace().Msg("Starting EncryptWithAgeKey function")

    // Create a cypher instance
    cypher := NewCypher()
    log.Debug().Msg("Cypher instance created")

    sopsConfig, err := LoadSopsConfig()
    if err != nil {
        log.Error().Err(err).Msg("Failed to load Sops config")
        return nil, err
    }
    log.Debug().Msg("Successfully loaded Sops config")

    var groups []sops.KeyGroup
    var ageKeys []string

    // Iterate over each creation rule and find matching files
    for _, rule := range sopsConfig.CreationRules {
        if err != nil {
            log.Error().Err(err).Msg("Invalid path regex in .sops.yaml")
            return nil, fmt.Errorf("invalid path regex in .sops.yaml: %v", err)
        }
        ageKeys = append(ageKeys, rule.Age)
    }

    log.Debug().Strs("ageKeys", ageKeys).Msg("Collected age keys from creation rules")

    for _, ageKey := range helper.UniqueNonEmptyElementsOf(ageKeys) {
        var keyGroup sops.KeyGroup
        keyGroup = append(keyGroup, NewMasterKey(ageKey))
        groups = append(groups, keyGroup)
    }

    log.Debug().Msg("Key groups created for encryption")

    // Encrypt the data using the sops key
    encryptedData, err := cypher.Encrypt(body, EncryptionConfig{
        Keys:              groups,
        UnencryptedSuffix: "",
        EncryptedSuffix:   "",
        UnencryptedRegex:  "",
        EncryptedRegex:    regex,
        ShamirThreshold:   3,
        Format:            format,
    })
    if err != nil {
        log.Error().Err(err).Msg("Error encrypting data")
        return nil, fmt.Errorf("error encrypting data: %v", err)
    }

    log.Debug().Msg("Data encrypted successfully")
    return encryptedData, nil
}

/// Custom keygroup

func NewMasterKey(pubkey string) (result keys.MasterKey) {
    log.Trace().Str("pubkey", pubkey).Msg("Creating new master key")

    result, err := age.MasterKeyFromRecipient(pubkey)
    if err != nil {
        log.Error().Err(err).Msg("Failed to create master key from recipient")
    }

    return result
}

/// IMPORTED

const (
    formatYaml = "yaml"
    formatJson = "json"
)

type Cypher interface {
    Decrypt(content []byte, config string) ([]byte, error)
    Encrypt(data []byte, config EncryptionConfig) ([]byte, error)
}

type cypher struct{}

func NewCypher() Cypher {
    log.Debug().Msg("Creating new cypher instance")
    return &cypher{}
}

func (c *cypher) Decrypt(content []byte, format string) ([]byte, error) {
    log.Trace().Msg("Decrypting content")
    decryptedData, err := decrypt.Data(content, format)
    if err != nil {
        log.Error().Err(err).Msg("Error during decryption")
        return nil, err
    }
    log.Info().Msg("Content decrypted successfully")
    return decryptedData, nil
}

type EncryptionConfig struct {
    Format            string
    Keys              []sops.KeyGroup
    UnencryptedSuffix string
    EncryptedSuffix   string
    UnencryptedRegex  string
    EncryptedRegex    string
    ShamirThreshold   int
}

func (m *cypher) Encrypt(content []byte, encrConfig EncryptionConfig) (result []byte, err error) {
    log.Trace().Msg("Starting encryption process")

    var store common.Store
    switch encrConfig.Format {
    case formatYaml:
        store = common.StoreForFormat(formats.Yaml, config.NewStoresConfig())
    default:
        store = common.StoreForFormat(formats.Json, config.NewStoresConfig())
    }

    log.Debug().Msg("Store initialized for encryption")

    branches, err := store.LoadPlainFile(content)
    if err != nil {
        log.Error().Err(err).Msg("Failed to load plain file for encryption")
        return nil, err
    }
    log.Debug().Msg("Plain file loaded successfully")

    tree := sops.Tree{
        Branches: branches,
        Metadata: sops.Metadata{
            KeyGroups:         encrConfig.Keys,
            UnencryptedSuffix: encrConfig.UnencryptedSuffix,
            EncryptedSuffix:   encrConfig.EncryptedSuffix,
            UnencryptedRegex:  encrConfig.UnencryptedRegex,
            EncryptedRegex:    encrConfig.EncryptedRegex,
            Version:           version.Version,
            ShamirThreshold:   encrConfig.ShamirThreshold,
        },
    }

    dataKey, errs := tree.GenerateDataKeyWithKeyServices(
        []keyservice.KeyServiceClient{keyservice.NewLocalClient()},
    )

    if len(errs) > 0 {
        log.Error().Err(err).Msg("Could not generate data key")
        return nil, errors.New(fmt.Sprint("Could not generate data key:", errs))
    }

    log.Debug().Msg("Data key generated successfully")

    encryptTreeOpts := common.EncryptTreeOpts{
        DataKey: dataKey,
        Tree:    &tree,
        Cipher:  aes.NewCipher(),
    }

    err = common.EncryptTree(encryptTreeOpts)
    if err != nil {
        log.Error().Err(err).Msg("Error during tree encryption")
        return nil, err
    }

    log.Debug().Msg("Tree encrypted successfully")
    return store.EmitEncryptedFile(tree)
}

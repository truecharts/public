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
	"github.com/truecharts/private/clustertool/pkg/helper"
)

var encrConfig *EncryptionConfig

const ageKeyFilePath = "./age.agekey"

func EncryptWithAgeKey(body []byte, regex string, format string) ([]byte, error) {

	// Create a cypher instance
	cypher := NewCypher()

	sopsConfig, err := LoadSopsConfig()
	if err != nil {
		return nil, err
	}

	var groups []sops.KeyGroup
	var ageKeys []string

	// Iterate over each creation rule and find matching files
	for _, rule := range sopsConfig.CreationRules {
		if err != nil {
			return nil, fmt.Errorf("invalid path regex in .sops.yaml: %v", err)
		}
		ageKeys = append(ageKeys, rule.Age)
	}

	for _, ageKey := range helper.UniqueNonEmptyElementsOf(ageKeys) {
		var keyGroup sops.KeyGroup
		keyGroup = append(keyGroup, NewMasterKey(ageKey))
		groups = append(groups, keyGroup)

	}

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
		return nil, fmt.Errorf("error encrypting data: %v", err)
	}

	return encryptedData, nil
}

/// Custom keygroup

func NewMasterKey(pubkey string) (result keys.MasterKey) {
	result, err := age.MasterKeyFromRecipient(pubkey)
	if err != nil {

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
	return &cypher{}
}

func (c *cypher) Decrypt(content []byte, format string) ([]byte, error) {
	return decrypt.Data(content, format)
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
	var store common.Store
	switch encrConfig.Format {
	case formatYaml:
		store = common.StoreForFormat(formats.Yaml, config.NewStoresConfig())
	default:
		store = common.StoreForFormat(formats.Json, config.NewStoresConfig())
	}

	branches, err := store.LoadPlainFile(content)
	if err != nil {
		return
	}

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
		return nil, errors.New(fmt.Sprint("Could not generate data key:", errs))
	}

	encryptTreeOpts := common.EncryptTreeOpts{
		DataKey: dataKey,
		Tree:    &tree,
		Cipher:  aes.NewCipher(),
	}
	err = common.EncryptTree(encryptTreeOpts)
	if err != nil {
		return nil, err
	}

	return store.EmitEncryptedFile(tree)
}

//go:build windows && amd64
// +build windows,amd64

package embed

import (
	"embed"
)

//go:embed windows_amd64/*
var StaticFiles embed.FS

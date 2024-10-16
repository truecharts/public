//go:build windows && arm64
// +build windows,arm64

package embed

import (
	"embed"
)

//go:embed windows_arm64/*
var StaticFiles embed.FS

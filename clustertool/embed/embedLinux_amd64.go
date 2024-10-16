//go:build linux && amd64
// +build linux,amd64

package embed

import (
	"embed"
)

//go:embed linux_amd64
var StaticFiles embed.FS

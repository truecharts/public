//go:build freebsd && arm64
// +build freebsd,arm64

package embed

import (
	"embed"
)

//go:embed freebsd_arm64
var StaticFiles embed.FS

//go:build freebsd && amd64
// +build freebsd,amd64

package embed

import (
	"embed"
)

//go:embed freebsd_amd64
var StaticFiles embed.FS

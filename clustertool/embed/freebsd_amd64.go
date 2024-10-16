//go:build darwin && amd64
// +build darwin,amd64

package embed

import (
	"embed"
)

//go:embed darwin_amd64
var StaticFiles embed.FS

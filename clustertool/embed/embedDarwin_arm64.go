//go:build darwin && arm64
// +build darwin,arm64

package embed

import (
	"embed"
)

//go:embed darwin_arm64
var StaticFiles embed.FS

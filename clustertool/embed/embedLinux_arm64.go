//go:build linux && arm64
// +build linux,arm64

package embed

import (
    "embed"
)

//go:embed linux_arm64
var StaticFiles embed.FS

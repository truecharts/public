package cmd

import (
    "log"
    "os"

    "github.com/spf13/cobra"
    "github.com/spf13/cobra/doc"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

var gendocsCmd = &cobra.Command{
    Use:    "gentooldocs",
    Short:  "Generate documentation for the CLI",
    Args:   cobra.ExactArgs(1),
    Hidden: true,
    Run: func(cmd *cobra.Command, args []string) {
        outdir := args[0]
        tmpdir := helper.DocsCache

        if err := os.MkdirAll(tmpdir, 0o777); err != nil {
            log.Fatal(err)
        }

        err := doc.GenMarkdownTree(RootCmd, tmpdir)
        if err != nil {
            log.Fatal(err)
        }
        helper.ToolDocs(tmpdir, outdir)
    },
}

func init() {
    adv.AddCommand(gendocsCmd)
}

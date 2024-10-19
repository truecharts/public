package image

import (
    "strings"
    "testing"
)

type args struct {
    tag string
}
type testdata struct {
    name    string
    args    args
    want    string
    wantErr bool
}

func TestCleanTag(t *testing.T) {
    tests := []testdata{
        // No match with any pattern tests
        {
            name: "Test valid SemVer format",
            args: args{
                tag: "1.2.3",
            },
            want:    "1.2.3",
            wantErr: false,
        },
        {
            name: "Test pattern that cannot be converted to SemVer",
            args: args{
                tag: "latest",
            },
            want:    "latest",
            wantErr: false,
        },
        {
            name: "Test empty tag",
            args: args{
                tag: "",
            },
            want:    "",
            wantErr: true,
        },
        {
            name: "Test tag with only whitespace",
            args: args{
                tag: "   ",
            },
            want:    "",
            wantErr: true,
        },
        {
            name: "Test full tag with digest",
            args: args{
                tag: "1.2.3@sha256:abc123",
            },
            want: "1.2.3",
        },
        {
            name: "Test tag with longer version and `-suffix`",
            args: args{
                tag: "1.2.3.4-suffix",
            },
            want: "1.2.3.4",
        },
        {
            name: "Test tag with semver and `-suffix`",
            args: args{
                tag: "1.2.3-abc12367",
            },
            want: "1.2.3",
        },
        {
            name: "Test tag with calver and `-suffix`",
            args: args{
                tag: "2023.11.2-abc12367",
            },
            want: "2023.11.2",
        },
        {
            name: "Test with invalid label format",
            args: args{
                tag: strings.Repeat("a", 300),
            },
            want:    "",
            wantErr: true,
        },
        // cleanSha tests
        {
            name: "Test cleanSha",
            args: args{
                tag: "1.2.3@sha256:abc123",
            },
            want: "1.2.3",
        },
        // cleanLeadingSymbol tests
        {
            name: "Test cleanLeadingSymbol ($)",
            args: args{
                tag: "$1.2.3",
            },
            want: "1.2.3",
        },
        {
            name: "Test cleanLeadingSymbol (v)",
            args: args{
                tag: "v1.2.3",
            },
            want: "1.2.3",
        },
        {
            name: "Test cleanLeadingSymbol (version)",
            args: args{
                tag: "version-a78f38c1",
            },
            want: "a78f38c1",
        },
        // keepShortCommitHashSuffix tests
        {
            name: "Test keepShortCommitHashSuffix (something-hash)",
            args: args{
                tag: "something-abcd123",
            },
            want: "abcd123",
        },
        {
            name: "Test keepShortCommitHashSuffix (version-hash)",
            args: args{
                tag: "version-abcd123",
            },
            want: "abcd123",
        },
        // cleanIncompleteSemVer tests
        {
            name: "Test cleanIncompleteSemVer (2 parts)",
            args: args{
                tag: "1.2",
            },
            want: "1.2.0",
        },
        {
            name: "Test cleanIncompleteSemVer (1 part)",
            args: args{
                tag: "1",
            },
            want: "1.0.0",
        },
        {
            name: "Test cleanIncompleteSemVer (more than 3 parts)",
            args: args{
                tag: "1.2.3.4.5",
            },
            want: "1.2.3.4.5",
        },
        {
            name: "Test cleanIncompleteSemVer (with suffix)",
            args: args{
                tag: "2.440-jdk17",
            },
            want: "2.440.0",
        },
        // cleanYearMonthDay tests
        {
            name: "Test cleanYearMonthDay (year-month-day)",
            args: args{
                tag: "2023-11-15",
            },
            want: "2023.11.15",
        },
        {
            name: "Test cleanYearMonthDay (year-month)",
            args: args{
                tag: "2022-04",
            },
            want: "2022.4.0",
        },
        {
            name: "Test cleanYearMonthDay (with prefix)",
            args: args{
                tag: "latest-2023-12-18",
            },
            want: "2023.12.18",
        },
        // cleanPrefix tests
        {
            name: "Test cleanPrefix (random prefix)",
            args: args{
                tag: "abc123-v1.2.3",
            },
            want: "1.2.3",
        },
        {
            name: "Test cleanPrefix (version prefix)",
            args: args{
                tag: "version-1.2.3",
            },
            want: "1.2.3",
        },
        // cleanArch tests
        {
            name: "Test cleanArch",
            args: args{
                tag: "x64-1.2.3",
            },
            want: "1.2.3",
        },
        // cleanRelease tests
        {
            name: "Test cleanRelease",
            args: args{
                tag: "RELEASE.2023-11-20T22-40-07Z",
            },
            want: "2023.11.20",
        },
        // cleanStupidSemVerLike tests
        {
            name: "Test cleanStupidSemVerLike",
            args: args{
                tag: "v.1.2.3",
            },
            want: "1.2.3",
        },
        {
            name: "Test cleanStupidSemVerLike (2)",
            args: args{
                tag: "V.1.2.3",
            },
            want: "1.2.3",
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {

            got, err := CleanTag(tt.args.tag)
            // If we expected an error, but didn't get one, fail the test
            if (err != nil) != tt.wantErr {
                t.Errorf("CleanTag() error = %v, wantErr %t", err, tt.wantErr)
                return
            }
            if got != tt.want {
                t.Errorf("CleanTag() got = %v, want %v", got, tt.want)
            }
        })
    }
}
func TestCheckValidLabelValue(t *testing.T) {
    tests := []testdata{
        {
            name: "Test invalid label format",
            args: args{
                tag: "1.2.3@sha256:abc123",
            },
            wantErr: true,
        },
        {
            name: "Test valid label format",
            args: args{
                tag: "1.2.3",
            },
            wantErr: false,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {

            err := checkValidLabelValue(tt.args.tag)
            // If we expected an error, but didn't get one, fail the test
            if (err != nil) != tt.wantErr {
                t.Errorf("checkValidLabelValue() error = %v, wantErr %t", err, tt.wantErr)
                return
            }
        })
    }
}

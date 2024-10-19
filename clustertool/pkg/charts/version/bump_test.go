package version

import "testing"

func TestIncrementVersion(t *testing.T) {
    type args struct {
        version string
        kind    string
    }

    tests := []struct {
        name    string
        args    args
        want    string
        wantErr bool
    }{
        {
            name: "Test increment major",
            args: args{
                version: "1.2.3",
                kind:    Major,
            },
            want:    "2.0.0",
            wantErr: false,
        },
        {
            name: "Test increment minor",
            args: args{
                version: "1.2.3",
                kind:    Minor,
            },
            want:    "1.3.0",
            wantErr: false,
        },
        {
            name: "Test increment patch",
            args: args{
                version: "1.2.3",
                kind:    Patch,
            },
            want:    "1.2.4",
            wantErr: false,
        },
        {
            name: "Test increment invalid",
            args: args{
                version: "1.2.3",
                kind:    "invalid",
            },
            want:    "",
            wantErr: true,
        },
        {
            name: "Test increment incomplete",
            args: args{
                version: "1.2",
                kind:    "invalid",
            },
            want:    "",
            wantErr: true,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {

            got, err := IncrementVersion(tt.args.version, tt.args.kind)
            // If we expected an error, but didn't get one, fail the test
            if (err != nil) != tt.wantErr {
                t.Errorf("IncrementVersion() error = %v, wantErr %t", err, tt.wantErr)
                return
            }
            if got != tt.want {
                t.Errorf("IncrementVersion() got = %v, want %v", got, tt.want)
            }
        })
    }
}

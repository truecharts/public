module.exports = {
  dryRun: false,
  username: "truecharts-admin",
  gitAuthor: "truecharts-admin <bot@truecharts.org>",
  onboarding: false,
  platform: "github",
  repositories: ["truecharts/charts"],
  allowPostUpgradeCommandTemplating: true,
  allowedPostUpgradeCommands: ["^.*"],
  regexManagers: [
    {
      fileMatch: ["(^|/)Chart\\.yaml$"],
      matchStrings: [
        '#\\s?renovate: image=(?<depName>.*?)\\s?appVersion:\\s?\\"?(?<currentValue>[\\w+\\.\\-]*)',
      ],
      datasourceTemplate: "docker",
    },
  ],
  packageRules: [
    {
      matchManagers: ["helm-requirements", "helm-values", "regex"],
      datasources: ["docker"],
      matchUpdateTypes: ["major"],
      postUpgradeTasks: {
        commands: [
          `
                if test -f "./charts/stable/{{{parentDir}}}/Chart.yaml"; then
                  train="stable"
                elif test -f "./charts/incubator/{{{parentDir}}}/Chart.yaml"; then
                  train="incubator"
                elif test -f "./charts/SCALE/{{{parentDir}}}/Chart.yaml"; then
                  train="SCALE"
                elif test -f "./charts/library/{{{parentDir}}}/Chart.yaml"; then
                  train="library"
                elif test -f "./charts/dependency/{{{parentDir}}}/Chart.yaml"; then
                  train="dependency"
                elif test -f "./charts/core/{{{parentDir}}}/Chart.yaml"; then
                  train="core"
                elif test -f "./charts/games/{{{parentDir}}}/Chart.yaml"; then
                  train="games"
                elif test -f "./charts/enterprise/{{{parentDir}}}/Chart.yaml"; then
                  train="enterprise"
                elif test -f "./charts/operators/{{{parentDir}}}/Chart.yaml"; then
                  train="operators"
                else
                  train="incubator"
                fi
                version=$(grep '^version:' {{{parentDir}}}/Chart.yaml | awk '{print $2}')
                major=$(echo $version | cut -d. -f1)
                minor=$(echo $version | cut -d. -f2)
                patch=$(echo $version | cut -d. -f3)
                minor=$(expr $minor + 1)
                echo "Replacing $version with $major.$minor.$patch"
                sed -i "s/^version:.*/version: $\{major\}.$\{minor\}.$\{patch\}/g" ./charts/${train}/{{{parentDir}}}/Chart.yaml
                cat ./charts/${train}/{{{parentDir}}}/Chart.yaml
                `,
        ],
      },
      fileFilters: ["**/Chart.yaml"],
      executionMode: "branch",
    },
    {
      matchManagers: ["helm-requirements", "helm-values", "regex"],
      datasources: ["docker"],
      matchUpdateTypes: ["minor"],
      postUpgradeTasks: {
        commands: [
          `
                if test -f "./charts/stable/{{{parentDir}}}/Chart.yaml"; then
                  train="stable"
                elif test -f "./charts/incubator/{{{parentDir}}}/Chart.yaml"; then
                  train="incubator"
                elif test -f "./charts/SCALE/{{{parentDir}}}/Chart.yaml"; then
                  train="SCALE"
                elif test -f "./charts/library/{{{parentDir}}}/Chart.yaml"; then
                  train="library"
                elif test -f "./charts/dependency/{{{parentDir}}}/Chart.yaml"; then
                  train="dependency"
                elif test -f "./charts/core/{{{parentDir}}}/Chart.yaml"; then
                  train="core"
                elif test -f "./charts/games/{{{parentDir}}}/Chart.yaml"; then
                  train="games"
                elif test -f "./charts/enterprise/{{{parentDir}}}/Chart.yaml"; then
                  train="enterprise"
                elif test -f "./charts/operators/{{{parentDir}}}/Chart.yaml"; then
                  train="operators"
                else
                  train="incubator"
                fi
                version=$(grep '^version:' {{{parentDir}}}/Chart.yaml | awk '{print $2}')
                major=$(echo $version | cut -d. -f1)
                minor=$(echo $version | cut -d. -f2)
                patch=$(echo $version | cut -d. -f3)
                minor=$(expr $minor + 1)
                echo "Replacing $version with $major.$minor.$patch"
                sed -i "s/^version:.*/version: $\{major\}.$\{minor\}.$\{patch\}/g" ./charts/${train}/{{{parentDir}}}/Chart.yaml
                cat ./charts/${train}/{{{parentDir}}}/Chart.yaml
                `,
        ],
      },
      fileFilters: ["**/Chart.yaml"],
      executionMode: "branch",
    },
    {
      matchManagers: ["helm-requirements", "helm-values", "regex"],
      datasources: ["docker"],
      matchUpdateTypes: ["patch", "digest", "pin"],
      postUpgradeTasks: {
        commands: [
          `
                if test -f "./charts/stable/{{{parentDir}}}/Chart.yaml"; then
                  train="stable"
                elif test -f "./charts/incubator/{{{parentDir}}}/Chart.yaml"; then
                  train="incubator"
                elif test -f "./charts/SCALE/{{{parentDir}}}/Chart.yaml"; then
                  train="SCALE"
                elif test -f "./charts/library/{{{parentDir}}}/Chart.yaml"; then
                  train="library"
                elif test -f "./charts/dependency/{{{parentDir}}}/Chart.yaml"; then
                  train="dependency"
                elif test -f "./charts/core/{{{parentDir}}}/Chart.yaml"; then
                  train="core"
                elif test -f "./charts/games/{{{parentDir}}}/Chart.yaml"; then
                  train="games"
                elif test -f "./charts/enterprise/{{{parentDir}}}/Chart.yaml"; then
                  train="enterprise"
                elif test -f "./charts/operators/{{{parentDir}}}/Chart.yaml"; then
                  train="operators"
                else
                  train="incubator"
                fi
                version=$(grep '^version:' {{{parentDir}}}/Chart.yaml | awk '{print $2}')
                major=$(echo $version | cut -d. -f1)
                minor=$(echo $version | cut -d. -f2)
                patch=$(echo $version | cut -d. -f3)
                minor=$(expr $minor + 1)
                echo "Replacing $version with $major.$minor.$patch"
                sed -i "s/^version:.*/version: $\{major\}.$\{minor\}.$\{patch\}/g" ./charts/${train}/{{{parentDir}}}/Chart.yaml
                cat ./charts/${train}/{{{parentDir}}}/Chart.yaml
                `,
        ],
      },
      fileFilters: ["**/Chart.yaml"],
      executionMode: "branch",
    },
  ],
};

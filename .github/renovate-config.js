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
          `     version=$(grep '^version:' {{{packageFileDir}}}/Chart.yaml | awk '{print $2}')
                major=$(echo $version | cut -d. -f1)
                minor=$(echo $version | cut -d. -f2)
                patch=$(echo $version | cut -d. -f3)
                minor=$(expr $minor + 1)
                echo "Replacing $version with $major.$minor.$patch"
                sed -i "s/^version:.*/version: $\{major\}.$\{minor\}.$\{patch\}/g" /{{{packageFileDir}}}/Chart.yaml
                cat {{{packageFileDir}}}/Chart.yaml
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
          `     version=$(grep '^version:' {{{packageFileDir}}}/Chart.yaml | awk '{print $2}')
                major=$(echo $version | cut -d. -f1)
                minor=$(echo $version | cut -d. -f2)
                patch=$(echo $version | cut -d. -f3)
                minor=$(expr $minor + 1)
                echo "Replacing $version with $major.$minor.$patch"
                sed -i "s/^version:.*/version: $\{major\}.$\{minor\}.$\{patch\}/g" /{{{packageFileDir}}}/Chart.yaml
                cat {{{packageFileDir}}}/Chart.yaml
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
          `     version=$(grep '^version:' {{{packageFileDir}}}/Chart.yaml | awk '{print $2}')
                major=$(echo $version | cut -d. -f1)
                minor=$(echo $version | cut -d. -f2)
                patch=$(echo $version | cut -d. -f3)
                minor=$(expr $minor + 1)
                echo "Replacing $version with $major.$minor.$patch"
                sed -i "s/^version:.*/version: $\{major\}.$\{minor\}.$\{patch\}/g" /{{{packageFileDir}}}/Chart.yaml
                cat {{{packageFileDir}}}/Chart.yaml
                `,
        ],
      },
      fileFilters: ["**/Chart.yaml"],
      executionMode: "branch",
    },
  ],
};

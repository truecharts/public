module.exports = {
  dryRun: false,
  username: 'truecharts-bot',
  gitAuthor: 'truecharts-bot <bot@truecharts.org>',
  onboarding: false,
  platform: 'github',
  repositories: [
    'truecharts/apps',
  ],
  packageRules: [
    {
      description: 'lockFileMaintenance',
      matchUpdateTypes: [
        'pin',
        'digest',
        'patch',
        'minor',
        'major',
        'lockFileMaintenance',
      ],
      dependencyDashboardApproval: false,
      stabilityDays: 0,
    },
  ],
};

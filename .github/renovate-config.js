module.exports = {
  dryRun: false,
  username: 'truecharts-bot',
  gitAuthor: 'truecharts-bot <bot@truecharts.org>',
  onboarding: false,
  platform: 'github',
  repositories: [
    'truecharts/library-charts',
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

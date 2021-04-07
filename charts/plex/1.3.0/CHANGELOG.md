* Application liveness / readiness probes were updated addressing a bug where TrueNAS failed
to consider plex application as `Active` if it was configured to only use `HTTPS`.

* Nvidia GPU support was properly added which ensures users having NVIDIA gpu can now consume it
for hardware acceleration.

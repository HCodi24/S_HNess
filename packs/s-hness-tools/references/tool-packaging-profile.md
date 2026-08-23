# Tool Packaging Profile

Define delivery as a lifecycle rather than only a build artifact.

## Artifact matrix

For each supported OS, architecture, host application, and runtime, identify the artifact, stable ID, version, prerequisites, entry point, and compatibility range. Prefer reproducible builds and pinned build inputs where the project supports them.

## Configuration and secrets

Separate build-time, install-time, and runtime settings. Define precedence, validation, migration, and safe defaults. Keep credentials out of source, logs, and packaged defaults.

## Lifecycle

Specify clean install, first run, upgrade, downgrade policy, data/config migration, rollback, repair, uninstall, and retained user data. Avoid removing user-owned data by default.

## Release evidence

Include artifact integrity, build results, package inspection, install smoke test, launch or load test, update/rollback test, uninstall test, compatibility evidence, and signing/notarization status when required.

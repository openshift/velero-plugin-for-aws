# AGENTS.md — AI Agent Instructions for openshift/velero-plugin-for-aws

## Project Overview
This is the OpenShift fork of the Velero Plugin for AWS. It provides Velero plugins for AWS services: an object store plugin for S3 and a volume snapshotter plugin for EBS. Maintained on the `oadp-dev` branch with UBI-based container images for the OADP ecosystem.

- **Primary Language**: Go
- **Module**: `github.com/vmware-tanzu/velero-plugin-for-aws`
- **Default Branch**: `oadp-dev`

## Build Instructions
```bash
# Build the plugin binary locally
make local

# Build container image
make container
```

## Test Instructions
```bash
# Run all tests
make test

# Run CI checks (modules verification + tests)
make ci

# Run specific tests
go test ./velero-plugin-for-aws/... -run TestName

# Vet code
go vet ./...
```

## Module Management
```bash
# Update Go modules
make modules

# Verify modules are tidy
make verify-modules
```

## Code Conventions
- Plugin implementations in `velero-plugin-for-aws/` directory
- Follow Velero plugin interface patterns (ObjectStore, VolumeSnapshotter)
- AWS SDK v2 for API interactions
- Changelog entries in `changelogs/`

## Project Structure
```
velero-plugin-for-aws/  - Plugin implementation
  object_store.go       - S3 object store plugin
  volume_snapshotter.go - EBS volume snapshotter plugin
changelogs/             - Release changelog entries
hack/                   - Build and CI scripts
```

## CI/CD
- GitHub Actions workflows in `.github/workflows/`:
  - `push.yml` — Push CI
  - `auto_assign_prs.yml` — Auto-assign PR reviewers
  - `auto_request_review.yml` — Auto-request reviews
- Reproduce CI locally:
  ```bash
  make ci
  ```

## Common Tasks

### Modifying the S3 object store plugin
1. Edit `velero-plugin-for-aws/object_store.go`
2. Run tests: `make test`
3. Add changelog entry

### Modifying the EBS volume snapshotter
1. Edit `velero-plugin-for-aws/volume_snapshotter.go`
2. Run tests: `make test`
3. Add changelog entry

### Updating OADP-specific patches
- OADP patches live on the `oadp-dev` branch
- UBI-based Dockerfile: `Dockerfile.ubi`

# STAMI delivery alignment

Source update: 2026-09-28. See [the shared policy and Expo findings](../../../nkp/stami-iceberg-platform/docs/stami-delivery-and-service-alignment.md)
and [the cross-project packet](../../../nkp/stami-iceberg-platform/plans/2026-09-28__vm-postgresql-and-delivery-alignment.execplan.md).

The new validation-only Bitbucket definition uses `stami.hosted`, the `ram16g`
host tier and a 2x/8 GiB budget with no Docker service. Two CRAN install workers
bound dependency compilation. The R base image pulls directly through Harbor's
Docker Hub proxy. CI installs required plotting/test packages, then runs the
existing `make test smoke`; optional NOArtisan branding is a separate gate.
This is an initial resource budget requiring actual runner measurement.

The checkout currently uses a GitHub remote. Pipeline source does not create
or activate a Bitbucket repository or runner. That owner handoff and remote CI
acceptance remain pending; no remote or release was changed.

The local pre-change `make test` baseline fails the optional NOArtisan bridge:
`test-noartisan-bridge.R:16` calls absent `proportion_labeler()`. The unrelated
plot/test implementation is preserved. A clean generic CI environment without
NOArtisan intentionally skips that optional test; that is not branding acceptance
or a claim that the full local suite passed. Resolve the bridge in its own
bounded plotting task before claiming branded compatibility.

The package remains a pure R plot/SVG library. PostgreSQL host relocation,
Trino, governance APIs, application service boundaries and publication authority
belong to their existing owners. Expo provides delivery/interface examples,
not a requirement to make this library a deployed microservice. No database
client, framework change or service API is added.

`make smoke`, the new R helper parse, pipeline YAML, central links and
`git diff --check` pass. Remote CI, bootstrap cache pulls and optional branded acceptance are unverified.
Common lessons are contributed centrally in Memory of Cod.

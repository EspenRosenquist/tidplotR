# Context - tidplotR

## Why This Repository Exists

`tidplotR` exists to separate generic plotting and deterministic SVG export from
the broader data-flow responsibilities in `tidflowR`.

It is a standalone R package. It borrows the low-token steering ritual from
`report-platform-workspace`, but it is not governed by that workspace and must
not carry deployment, connector, or orchestration tooling.

The immediate trigger for the split is that `svglite` is the right SVG device
for the work, but it brings a deeper native text-shaping stack on Linux.
Keeping that stack isolated in a plot-focused package makes the boundary
clearer: `tidflowR` handles data flow and contract assembly, while `tidplotR`
turns already-shaped data into plots and SVG assets.

## Shared High-Level Workflow

`tidplotR` is intentionally late-stage in the reporting pipeline:

1. Receive already-shaped data frames and lightweight definition lists.
2. Build reusable `ggplot` objects for time-oriented report views.
3. Write deterministic fixed-dimension SVG files for downstream renderers.

The SVG product surface should stay strict: explicit dimensions, predictable
file output, deterministic serialization as far as `svglite` allows, and
focused tests around product behavior.

## What Belongs In tidplotR

- generic ggplot builders that accept plain data frames
- deterministic SVG export helpers
- plot-specific validation and small internal helpers
- package documentation and examples that show standalone and tandem usage

## Keep Outside tidplotR

- YAML spec loading and validation
- database access, SQL assets, and connector/auth logic
- JSON contract assembly and final artifact manifests
- report-specific layout composition and page assembly
- domain-specific transforms, indicator catalogs, or warehouse contracts

## Intended Consumer Patterns

Standalone use:

- analysts or packages can hand `tidplotR` plain data frames and render plots
  directly without bringing in `tidflowR`

Tandem use with `tidflowR`:

- `tidflowR` prepares or aggregates data
- `tidplotR` renders reusable plots and SVG files into an assets directory

## Approved Direction

`tidplotR` must remain independent from `tidflowR`. It may pair naturally with
`tidflowR`, but it should not require it. Inputs should stay simple and generic
enough that the package can be used as a plotting toolbox on its own.

## Known Limitations At Scaffold Time

- The local repository exists under `/home/esro/analytid-platform/tidplotR` and
  has `origin/main` configured at `https://github.com/EspenRosenquist/tidplotR`.
- Generic plotting code has been scaffolded locally here, and `tidflowR` no
  longer owns the generic plotting implementation. Downstream migration remains
  open.
- No downstream consumer package has been repointed to `tidplotR` yet.
- The current state handoff is now `STATE.md`; future sessions should update it
  instead of relying on chat history.
- Local documentation, tests, and smoke checks now pass, but downstream
  consumer migration remains open.

## Next Session Starting Points

1. Audit the public plot/SVG surface against model-engine product expectations.
2. Move generic plot entrypoints in downstream consumers over to `tidplotR`.
3. Keep `tidflowR` free of plotting compatibility wrappers unless the boundary
   decision is explicitly revisited.
4. Keep the local repo and `origin/main` synchronized when publishing is
   requested.

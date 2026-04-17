# AI Instructions — tidplotR

These instructions guide any assistant working in this repository.

## Always

- Read `PROJECT_OVERVIEW.md` and `TODO.md` before making substantive changes.
- Keep work aligned with the current plan under `plans/` when a plan exists.
- Compare at least two options for architectural changes:
  - Option A: compatibility-first wrappers or migration helpers.
  - Option B: cleaner standalone plotting-package design.
- Quantify trade-offs in human time, complexity, regression risk, maintainability, and data correctness.
- Prefer shallow dependencies. Use base R transformations when they keep the code clear and materially reduce dependency depth.
- Keep exported functions usable with plain data frames and simple lists so tidplotR stays independent from tidflowR.
- Preserve downstream wrapper compatibility unless there are large gains to be made and an approved decision explicitly changes it.
- Include verification steps for every substantive change.

## When To Ask For Clarification

Ask only when:

- a required detail cannot be deduced from the repo or current documents
- a decision gate in `PROJECT_OVERVIEW.md` is crossed
- two mutually exclusive behaviors are still genuinely unresolved

Otherwise, proceed with explicit assumptions and record them.

## Deliverable Discipline

For planning or implementation tasks, specify:

- which files change
- how to verify the change
- what assumptions were made
- what still remains open or deferred

## Never

- Do not introduce secrets into specs or committed files.
- Do not widen data access or change contract surfaces silently.
- Do not pull database, spec-loading, or JSON contract-assembly logic into tidplotR without recording why.

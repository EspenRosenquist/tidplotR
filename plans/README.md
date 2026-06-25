# plans/

Store Exec Plans here.

## Naming

Use this name for new plans:

- `YYYY-MM-DD__short-title.execplan.md`

Historical `*.plan.md` files remain valid references. Do not rename them just
for churn.

## When to create or update a plan

Use a plan when work:

- crosses a decision gate in `PROJECT_OVERVIEW.md`
- changes public plot contracts or SVG behavior
- changes strict SVG product shape, dimensions, or file-output expectations
- changes dependency posture
- affects downstream package contracts
- is expected to take more than 2 to 4 hours

Before editing a plan, read `PROJECT_OVERVIEW.md`, `STATE.md`, `TODO.md`, and
`DECISIONS.md`.

## Plan shape

Keep plans compact and update them during execution:

1. Objective and done condition.
2. Constraints and decision gates.
3. Options with quantified trade-offs.
4. Proposed approach.
5. Execution steps.
6. Acceptance and verification.
7. Rollback and rerun safety.
8. Progress, surprises, and decisions.

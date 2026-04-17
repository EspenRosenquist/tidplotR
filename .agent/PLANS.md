# PLANS — ExecPlan Standard (Repository Policy)

This file defines the required structure for **ExecPlans** in this repository.

An ExecPlan is a **self-contained, living implementation plan** intended to:
- prevent goal drift,
- avoid “reinventing working parts,”
- enable clean restarts if context is lost,
- and provide a clear execution and verification path.

## Where plans live
- Store ExecPlans in `plans/` as: `YYYY-MM-DD__short-title.execplan.md`
- Link plans from the corresponding Issue and PR.

## ExecPlan required when
See `AGENTS.md` for the normative triggers.

## Autonomy rule (important)
When an ExecPlan is required, the assistant should:
1) Read `PROJECT_CONSTITUTION.md`, `INVARIANTS.md`, `TODO.md`, and `METRICS.md`.
2) Draft the ExecPlan **from the assignment** and repo context.
3) Ask questions **only** if a Decision Gate is crossed or a missing fact blocks safe progress.

## ExecPlan template (copy/paste)

> Notes:
> - Replace `{{PLACEHOLDER}}`.
> - Keep it short. Most plans should fit on 1–2 pages.
> - Use **N/A** where a section does not apply.

---

# ExecPlan — {{TITLE}}

- Date: {{YYYY-MM-DD}}
- Owner(s): {{NAME(S)}}
- Status: Draft | Accepted | In Progress | Done
- Links: Issue {{#}}, PR {{#}}, Docs {{links}}

## 1) Objective (2–5 bullets)
- {{What will be delivered}}
- {{Why it matters (tie to Goal Stack)}}
- Done when: {{one sentence}}

## 2) Constraints & invariants (short)
- Must respect: `PROJECT_CONSTITUTION.md`, `INVARIANTS.md`
- Key constraints: {{3–6 bullets}}
- Decision gates crossed? {{Yes/No — if Yes, list gate(s) and require approval}}

## 3) Options & quantified evaluation (required)
Use the rubric in `METRICS.md`. Keep this section brief.

| Option | Human time | Complexity | Regression risk | Maintainability | Dependencies | Notes |
|---|---|---:|---:|---:|---|---|
| A (minimal-diff / preference-compatible) | {{}} | {{}} | {{}} | {{}} | {{}} | {{}} |
| B (efficiency-first / platform-native) | {{}} | {{}} | {{}} | {{}} | {{}} | {{}} |

**Recommendation:** {{A or B}}
**RFC triggered?** Yes/No — if Yes, link or embed a short RFC summary.

## 4) Proposed approach (short narrative)
{{1–2 paragraphs describing the chosen approach, key interfaces touched, and why it is best under the current weights.}}

## 5) Execution steps (small, verifiable increments)
Prefer PR-sized increments. Include commands and file paths where relevant.

- [ ] Step 1: {{specific, small}}
- [ ] Step 2: {{specific, small}}
- [ ] Step 3: {{specific, small}}

## 6) Acceptance & verification (N/A allowed)
Define how we will know it works. Prefer using existing tests/tools if they exist.

- Build/lint: {{command or N/A}}
- Unit/integration tests: {{command or N/A}}
- Smoke test / manual check: {{what to run/click or N/A}}
- Contract checks (API/schema/interface): {{what must stay stable or N/A}}
- Security/privacy checks (if relevant): {{steps or N/A}}
- Performance checks (if relevant): {{steps or N/A}}

## 7) Rollback & recovery (only if needed; N/A allowed)
- Rollback: {{how to revert safely, or N/A}}
- Recovery / rerun safety (stateful ops): {{how to re-run safely, or N/A}}

## 8) Progress log (living, lightweight)
- {{YYYY-MM-DD}} — {{what changed; what remains; next step}}

## 9) Surprises & decisions (living, lightweight)
- {{YYYY-MM-DD}} — {{surprise or decision}} → {{impact}} → {{what we did}} (link)

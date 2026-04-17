# Plan Template

This template defines the structure for **Exec Plans** (implementation plans) in this repository.  A plan is a short, living document intended to prevent goal drift, avoid reinvention of working parts, and provide a clear execution and verification path.

Plans live in the `plans/` directory and are named `YYYY‑MM‑DD__short-title.plan.md`.  Link the plan from your issue and pull request.  The assistant should draft the plan when a plan trigger applies (see `PROJECT_OVERVIEW.md`) and ask questions only if a decision gate is crossed or critical information is missing.

---

# {{TITLE}}

**Date:** {{YYYY‑MM‑DD}}  
**Owner(s):** {{Name(s)}}  
**Status:** Draft | Accepted | In Progress | Done  
**Links:** Issue {{#}} | PR {{#}} | Docs {{links}}

## 1) Objective (2–5 bullets)
- {{What will be delivered}}
- {{Why it matters (tie to the Goal Stack)}}
- **Done when:** {{One sentence describing completion}}

## 2) Constraints & invariants (brief)

- Must respect `PROJECT_OVERVIEW.md`.
- Key constraints: {{3–6 bullets}}
- Decision gates crossed? {{Yes/No — if Yes, list gate(s) and ensure approval}}

## 3) Options & quantified evaluation (required)

Compare at least two options using the optimisation weights.  Keep this table brief.

| Option | Human time | Complexity | Regression risk | Maintainability | Dependencies | Notes |
|---|---|---:|---:|---:|---|---|
| A (baseline / preference‑compatible) | {{}} | {{}} | {{}} | {{}} | {{}} | {{}} |
| B (efficiency‑first / platform‑native) | {{}} | {{}} | {{}} | {{}} | {{}} | {{}} |

**Recommendation:** {{A or B}}

## 4) Proposed approach (short narrative)

{{Describe the chosen option and why it is best under the current weights.  Mention key interfaces or files that will be touched.}}

## 5) Execution steps (small, verifiable increments)

- [ ] Step 1: {{Specific, small}}
- [ ] Step 2: {{Specific, small}}
- [ ] Step 3: {{Specific, small}}

## 6) Acceptance & verification

Define how success will be verified.  Use N/A for sections that do not apply.

- **Build/lint:** {{command or N/A}}
- **Tests:** {{command or N/A}}
- **Smoke test / manual check:** {{what to run/click or N/A}}
- **Contract checks:** {{what must stay stable or N/A}}
- **Security/privacy checks:** {{steps or N/A}}
- **Performance checks:** {{steps or N/A}}

## 7) Rollback & recovery (optional)

- **Rollback:** {{how to revert safely, or N/A}}
- **Recovery / rerun safety:** {{how to re‑run safely for stateful operations, or N/A}}

## 8) Progress log (living, lightweight)

Keep a running log of progress as the work proceeds.  Add new entries on top.

- {{YYYY‑MM‑DD}} — {{What changed; what remains; next step}}

## 9) Surprises & decisions (living, lightweight)

Record surprises, discoveries or decisions here.  Link to issue or PR when relevant.

- {{YYYY‑MM‑DD}} — {{Surprise or decision}} → {{Impact}} → {{Action taken}}

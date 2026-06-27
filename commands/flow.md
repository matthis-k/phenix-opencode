---
description: Run full Phenix plan -> architecture -> implementation -> verification workflow
agent: workflow
---

Run the full Phenix workflow for this request:

$ARGUMENTS

1. Save original request to `.opencodestate/request.md`.
2. Ask planner for a full structured plan.
3. Save full planner output to `.opencodestate/planner-output.yaml`.
4. Extract and save:
   - `.opencodestate/implementation-plan.yaml`
   - `.opencodestate/planned-changes.yaml`
5. Ask architect to review the plan.
6. Save full architecture review to `.opencodestate/architecture-review.yaml`.
7. Save accepted architecture contract to `.opencodestate/architecture-contract.yaml`.
8. If architecture is rejected, return to planner.
9. Ask implementer to apply only accepted planned changes.
10. Save implementer output to `.opencodestate/implementation-summary.yaml`.
11. Ask verifier to verify:
    - mechanical checks
    - plan conformance against original plan artifacts
    - architecture conformance against original architecture contract
12. Save verifier output to `.opencodestate/verification-report.yaml`.
13. If verifier fails, ask failure-analyzer and save `.opencodestate/failure-analysis.yaml`.
14. Return to planner with failure analysis.

Before starting, discover repo contracts:

- `AGENTS.md`
- `docs/*`
- `CLAUDE.md` or `.claude/`
- `knowledge/`
- `CONTRIBUTING.md`

Do not skip architecture review. Do not edit tracked source files. Do not mark complete until verifier returns `status: passed`.

!`git status --short`

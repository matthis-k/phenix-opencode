---
description: Verify current diff against the accepted architecture contract
agent: architect
subtask: true
---

Perform a post-implementation architecture verification of the current diff.

Use the original architecture contract and planned architecture patterns.

Current status:

!`git status --short`

Current diff stat:

!`git diff --stat`

Current diff:

!`git diff`

Workflow state:

!`for f in .opencodestate/planner-output.yaml .opencodestate/implementation-plan.yaml .opencodestate/planned-changes.yaml .opencodestate/architecture-review.yaml .opencodestate/architecture-contract.yaml .opencodestate/implementation-summary.yaml; do if test -f "$f"; then echo "PRESENT $f"; else echo "MISSING $f"; fi; done`

Read artifacts:

!`test -f .opencodestate/architecture-contract.yaml && cat .opencodestate/architecture-contract.yaml || true`
!`test -f .opencodestate/implementation-summary.yaml && cat .opencodestate/implementation-summary.yaml || true`
!`test -f .opencodestate/planned-changes.yaml && cat .opencodestate/planned-changes.yaml || true`

Rules:

@AGENTS.md
@docs/repo-goals.md
@docs/agent-workflow.md
@docs/verification.md
@docs/codebase-memory.md

Return only the architect YAML with:

```yaml
review_kind: diff
```

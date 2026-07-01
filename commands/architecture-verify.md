---
description: Verify current diff against the accepted architecture contract
agent: architect
subtask: true
---

Perform a post-implementation architecture verification of the current diff.

Use the original architecture contract, active WorkScope, and planned
architecture patterns. Confirm WorkScope remains the single routing/capability
model; `c1`/`c2` direct routing and `c4` strict routing are preserved; release,
destructive, secrets/auth, and permission-policy actions remain explicit-gated.

Current status:

!`git status --short`

Current diff stat:

!`git diff --stat`

Current diff:

!`git diff`

Workflow state:

!`for f in .phenix-agent-state/planner-output.yaml .phenix-agent-state/implementation-plan.yaml .phenix-agent-state/planned-changes.yaml .phenix-agent-state/architecture-review.yaml .phenix-agent-state/architecture-contract.yaml .phenix-agent-state/implementation-summary.yaml; do if test -f "$f"; then echo "PRESENT $f"; else echo "MISSING $f"; fi; done`

Read artifacts:

!`test -f .phenix-agent-state/architecture-contract.yaml && cat .phenix-agent-state/architecture-contract.yaml || true`
!`test -f .phenix-agent-state/implementation-summary.yaml && cat .phenix-agent-state/implementation-summary.yaml || true`
!`test -f .phenix-agent-state/planned-changes.yaml && cat .phenix-agent-state/planned-changes.yaml || true`

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

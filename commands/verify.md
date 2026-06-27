---
description: Verify mechanical checks, plan conformance, and architecture of the current working tree
agent: verifier
subtask: true
---

Verify the current working tree.

This verification must include:

1. mechanical verification:
   - format
   - lint
   - typecheck
   - tests
   - flake/build checks

2. plan-conformance verification:
   - final diff matches original implementation plan
   - final diff matches planned changes
   - changed files are planned or explicitly justified

3. architecture verification:
   - final diff matches planned architecture contract
   - dependency direction preserved
   - module boundaries preserved
   - docs/tests/config consistent
   - no broad hidden redesign

Use codebase_memory tools for architecture verification when useful.

Current status:

!`git status --short`

Current diff stat:

!`git diff --stat`

Current diff:

!`git diff`

Workflow state:

!`for f in .opencodestate/request.md .opencodestate/planner-output.yaml .opencodestate/implementation-plan.yaml .opencodestate/planned-changes.yaml .opencodestate/architecture-review.yaml .opencodestate/architecture-contract.yaml .opencodestate/implementation-summary.yaml; do if test -f "$f"; then echo "PRESENT $f"; else echo "MISSING $f"; fi; done`

Read plan artifacts if present:

!`test -f .opencodestate/request.md && echo "REQUEST:" && cat .opencodestate/request.md || true`
!`test -f .opencodestate/implementation-plan.yaml && echo "PLAN:" && cat .opencodestate/implementation-plan.yaml || true`
!`test -f .opencodestate/planned-changes.yaml && echo "CHANGES:" && cat .opencodestate/planned-changes.yaml || true`
!`test -f .opencodestate/architecture-contract.yaml && echo "CONTRACT:" && cat .opencodestate/architecture-contract.yaml || true`
!`test -f .opencodestate/implementation-summary.yaml && echo "SUMMARY:" && cat .opencodestate/implementation-summary.yaml || true`

Relevant rules:

@AGENTS.md
@docs/repo-goals.md
@docs/agent-workflow.md
@docs/verification.md
@docs/codebase-memory.md

Return only the structured verifier YAML.

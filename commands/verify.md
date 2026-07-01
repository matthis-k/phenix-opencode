---
description: Verify mechanical checks, plan conformance, and architecture of the current working tree
agent: verifier
subtask: true
---

Verify the current working tree.

This verification must include:

0. WorkScope conformance:
   - active WorkScope is the single routing/capability model
   - capabilities, invariants, and boundaries are respected
   - git status/diff contain no unrelated or stale changes
   - c1/c2 did not require heavyweight state unless recovery/handoff applied
   - c4 plan conformance and architecture gates are present when required

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

Fail on unrelated changes, boundary or invariant violations, missing required c4
plan conformance, or unapproved commit/push/publish/deploy/tracked-delete/
secrets/auth/permission-policy actions. Verify evidence, not intent.

Use codebase_memory tools for architecture verification when useful.

Current status:

!`git status --short`

Current diff stat:

!`git diff --stat`

Current diff:

!`git diff`

Workflow state:

!`for f in .phenix-agent-state/request.md .phenix-agent-state/planner-output.yaml .phenix-agent-state/implementation-plan.yaml .phenix-agent-state/planned-changes.yaml .phenix-agent-state/architecture-review.yaml .phenix-agent-state/architecture-contract.yaml .phenix-agent-state/implementation-summary.yaml; do if test -f "$f"; then echo "PRESENT $f"; else echo "MISSING $f"; fi; done`

Read plan artifacts if present:

!`test -f .phenix-agent-state/request.md && echo "REQUEST:" && cat .phenix-agent-state/request.md || true`
!`test -f .phenix-agent-state/implementation-plan.yaml && echo "PLAN:" && cat .phenix-agent-state/implementation-plan.yaml || true`
!`test -f .phenix-agent-state/planned-changes.yaml && echo "CHANGES:" && cat .phenix-agent-state/planned-changes.yaml || true`
!`test -f .phenix-agent-state/architecture-contract.yaml && echo "CONTRACT:" && cat .phenix-agent-state/architecture-contract.yaml || true`
!`test -f .phenix-agent-state/implementation-summary.yaml && echo "SUMMARY:" && cat .phenix-agent-state/implementation-summary.yaml || true`

Relevant rules:

@AGENTS.md
@docs/repo-goals.md
@docs/agent-workflow.md
@docs/verification.md
@docs/codebase-memory.md

Return only the structured verifier YAML.

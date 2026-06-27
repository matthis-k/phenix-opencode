---
description: Review plan or diff against architecture rules
agent: architect
subtask: true
---

Perform an architecture review.

If plan context is provided, review the plan. If diff context is provided, review the diff.

Use codebase memory for structural context if relevant.

Current status:

!`git status --short`

Current diff stat (if diff review):

!`git diff --stat`

Rules:

@AGENTS.md
@docs/repo-goals.md
@docs/agent-workflow.md
@docs/verification.md
@docs/codebase-memory.md

Return only the structured architect YAML.

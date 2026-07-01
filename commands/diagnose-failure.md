---
description: Analyze a verifier failure and produce corrections for planner
agent: failure-analyzer
subtask: true
---

Analyze the verifier failure report and determine root causes.

Classify failures against the active WorkScope: capabilities, invariants,
boundaries, routing, verification expectations, and escalation triggers. Do not
recommend implicit commit, push, publish, or sync; release/destructive/security
failures require explicit user approval and c4 replanning.

Use codebase memory for architecture-related or cross-module failures.

Verifier report provided as context.

Rules:

@AGENTS.md
@docs/agent-workflow.md
@docs/verification.md
@docs/codebase-memory.md

Return only the structured failure-analyzer YAML.

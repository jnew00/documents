# DEV UP 2026: CFP Submission Draft
### "Everything Changed Except How We Measure It: Flow Metrics for the Agent Era"
**Owner:** Jason Newberg (D114629) · **Format:** Interactive Talk (45 min)

> Each field below is written to hit the reviewers' **Strong (75%)** signals and the conference theme (*Everything has changed*). Character counts are noted for every limited field. Copy each block directly into the form.

---

## Dropdown / selection fields

| Field | Recommended answer |
|---|---|
| **Type of Session** | **Interactive Talk (45 mins).** Presentation + live demo + Q&A. The build is a *demo you run*, not attendee hands-on, so it is not a Lab. Your act timings already sum to ~43 min, so it is feasible without rushing. |
| **Audience Level** | **General knowledge.** Attendees know velocity/PRs/CI and have used an AI coding tool; no flow-metrics or stats background assumed. Matches the Required Skill Set exactly (low mismatch risk). |
| **Who uses this solution (primary users)?** | **Firmwide** |
| **Voting Group (track)** | **Engineering Excellence** *(confirm against the live dropdown, see note at bottom).* Choose from the engineer's perspective, not your org's. |
| **Max Number of Team Members Excluding Project Owner** | **0** (solo). Enter `1` only if you add a co-presenter via My Project, Team Members section. |

---

## Project Title  *(75 / 100 chars)*

```
Everything Changed Except How We Measure It: Flow Metrics for the Agent Era
```

*Plays the conference theme ("Everything has changed") straight back, then twists it: the world changed, the way we measure didn't. The subtitle keeps the scope wide, flow metrics span the whole value stream, request to production, not just the coding step, and anchors it to the agent era. Clear, no hype, no acronyms, and strong on the theme-fit and "Why Now" signals.*

**Punchier alternative** if you ever want more edge (ties straight to your closing line, needs no subtitle):
```
Velocity Was Always Fiction. Agents Just Proved It.
```

---

## Project Description  *(~493 / 500 chars)*
**Structure: Problem, Context, Commitment. No agenda or takeaways here.**

```
Problem: AI agents now write much of our production code, yet teams still report progress in story-point velocity, a number that climbs whether or not quality actually held. Context: agents fan out dozens of sub-tasks, ship PRs overnight, and shift the bottleneck to human review, breaking the assumptions every Agile metric was built on. This session shows engineers how to measure honest, agent-aware flow: what to track, what to retire, and how the numbers behave once agents join the team.
```

---

## Project Benefits  *(~485 / 500 chars)*
**Benefit-first: what the firm gets, with one proven credibility point, honest about delivered vs projected.**

```
The benefit is delivery decisions made on numbers that hold up, instead of velocity that agents have inflated into noise. Teams get a trustworthy productivity signal, an early warning when agent code quality slips, and less estimation ceremony. The method already caught a measurement bug that made solid agent code look 44 points worse than it was. Largely projected today, baselined on current velocity reporting; success is bad numbers caught early and quality drift surfaced sooner.
```

> **Framed as a first-pass pilot, on purpose.** The numbers are preliminary (one repo, n=33), and the submission says so. That is a feature, not a risk: a talk about honest measurement gains credibility by scoping its own data. The methodology finding (51% vs 95%) holds no matter how many repos you analyze, so it carries the weight. Pending and fine to add post-acceptance: Effective WIP, Defect Escape Rate, Cost per Accepted Item.

---

## Required Skill Set  *(~480 / 500 chars)*
**Knowledge + Tools/access, matched to "General knowledge."**

```
Knowledge: comfort with everyday delivery concepts (sprints, velocity, pull requests, CI) and hands-on use of an AI coding assistant or agent. No prior background in flow metrics or statistics is needed; concepts are introduced as we go. Tools / access: none required to attend. The live build uses standard Jira and Git data; the open instrumentation shown can be reproduced later with access teams already have. No specialist tools, licenses, or setup are needed for this session.
```

---

## Provide specific details of who is using the solution  *(~492 / 500 chars)*
**Supports the Firmwide scope: persona, footprint, workflow.**

```
Any engineering team across lines of business that is adopting AI coding agents and still measures delivery in story points. Personas: software engineers, engineering managers, scrum masters, and delivery leads who own or report on team metrics. Footprint: applicable firmwide as agentic coding spreads; the more of a team's code agents write, the more its current metrics mislead. Primary workflow: planning, PR review, and the status/metrics reporting that feeds delivery and productivity goals.
```

---

## Call to Action  *(~315 / 500 chars)*
**One north star, broader than any single takeaway.**

```
Walk out able to measure and defend your team's real delivery in the age of agents: a single, honest flow view that replaces story-point velocity, built from data you already have, without new tooling, a reorg, or another estimation meeting. The goal isn't to track more; it's to finally trust the number you report.
```

---

## Why now for DEV UP?  *(~484 / 500 chars)*
**Trigger + consequence of inaction + evidence beyond one team. Does not restate the description.**

```
Trigger: agentic coding crossed from pilot to default this year. Gartner expects 40% of enterprise apps to embed task-specific AI agents by end of 2026, up from under 5% a year ago. The 2025 DORA report confirms AI lifts throughput but raises instability and rework across thousands of teams. If we don't fix measurement this planning cycle, AI-productivity goals lock onto inflated velocity, the review bottleneck stays invisible, and you won't know if quality held until production.
```

---

## Key Takeaways  *(~470 / 500 chars)*
**3 to 5 outcomes, each starting with an action verb, attendee-focused, all supporting the CTA.**

```
• Diagnose which of your current flow metrics agents have quietly broken, and why.
• Apply a six-metric, agent-aware scorecard that counts what survives review, not what agents generate (rework, cycle time, cost per accepted change).
• Separate system metrics (unified) from per-actor metrics (split); never average across humans and agents.
• Pressure-test any agent metric: one filter swung ours 51%→95%.
• Rebuild an honest flow view from your own Jira + Git, no new tooling.
```

---

## Session Outline (5 to 7 bullets, in order)  *(~479 / 500 chars)*
**Flow only, demo bullet flagged explicitly. Shows problem, approach, application.**

```
• Live poll: who tracks velocity, and who believes it?
• Why velocity was always weak, and what agents finally broke
• Five ways agents distort flow: fan-out WIP, lost cycle-time anchor, throughput inflation, shifted bottleneck, token cost
• The six-metric scorecard that survives agents
• The combination rule: unified system metrics vs split per-actor metrics
• Live demo: from Git in seconds, same repo, two methods swing Trust 51%→95%
• Migration path off velocity, without a reorg
```

---

## Before you submit, confirm these 2 things

1. **Voting Group / track.** I recommended *Engineering Excellence*, but I don't have your live track list. Pick the single best fit from the engineer's perspective, likely *Engineering Excellence*, or an *AI* / *Ways of Working* track if one exists.
2. **Confirm the pilot numbers are current** (Claude 94.8% / Copilot 95.6% trust, n=33, the 51%→95% swing). The three pending metrics (Effective WIP, Defect Escape Rate, Cost per Accepted Item) are fine to add after acceptance; the "this is the baseline, rerun in 6 months" framing covers them honestly.

### Source notes (for your defense, not the form)
- **Your pilot data is the primary evidence in Project Benefits**, scoped honestly as a first pass. Real, line-level, reproducible. Stronger than any borrowed industry stat, and the centerpiece of the talk's credibility.
- **Gartner: 40% of enterprise apps with task-specific AI agents by end of 2026** (from under 5% a year prior). Widely reported Gartner prediction; solid for the "why now" trigger.
- **2025 DORA: AI lifts throughput but raises instability/rework.** Primary, authoritative (DORA *State of AI-Assisted Software Development*, Sept 2025; AI Capabilities Model, Dec 2025). Safe to lean on hard, and note your pilot is the local exception that proves the "you must measure to know" point: the aggregate risk is real, your team came out healthy, and you only know because you measured.
- **Removed the "~23% incidents per PR" stat.** It came from a weak secondary source and contradicted your own no-drift finding. Don't reintroduce it. If you ever need an external instability number, use Faros AI's 2026 telemetry (22,000 developers): PR review time +441%, 31% of PRs merging with no review, epics/developer +66%.
- **Trust gap (optional add):** only ~29% of developers fully trust AI output (down from 70%+ in 2023), supporting evidence for why a measured Trust Ratio matters even when yours lands at 95%.

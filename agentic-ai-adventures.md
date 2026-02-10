# Vibe, Verify, Ship: My Nolan-Flavored Adventures in Agentic AI

I didn’t get hooked on agentic AI because it wrote a clever function.

I got hooked because it helped me jump into a completely new tech stack, build something real with my son, and ship it into the world. That combination, learning plus creating plus releasing, made it obvious this was not just autocomplete. It was a step change.

## The moment it clicked: learning Flutter by shipping a real game with my kid

A while back, I decided to build a game called **Inceptyon** with my son. I picked **Flutter/Dart**, which was brand new to me. Normally that would mean weeks of tutorials, dead ends, and that low-grade frustration of “I’m sure I’m doing this the hard way.”

Agentic AI changed the shape of the experience.

Instead of getting stuck, we kept moving. We’d build a slice, test it, adjust, expand. The agent helped translate “how I think about software” into “how this new framework wants me to build software.” That translation layer is a huge deal when you are learning.

And the wild part is that it wasn’t just code.

- We used AI to generate **voices for narration**, which instantly made the project feel alive.
- We built out **lore and storytelling** until the world felt bigger than a weekend hobby.
- We designed real **systems and mechanics**, not just a toy prototype.
- Then we did the thing most fun projects never do: we **shipped it** to the **Apple App Store** and **Google Play**.

That’s when it stopped being novelty and became a new way of creating.

## Great American Teach-In: the full circle moment

Later, I showed the game at **Great American Teach-In**, and watching a room full of kids light up when they realized “wait, you can make something like this?” was the moment it hit me: this tooling is not just productivity. It is empowerment.

It also gave me a new way to connect with my son. Building a world together is a different kind of collaboration. You are not just “doing a project.” You are building a shared canon, arguing about mechanics, laughing about lore, and shipping something you can point to.

That is the emotional core of why I still care about all this.

## The side quest that’s been waiting 10 years: Unwyned

The game got me hooked, but the ripple effect showed up everywhere else.

One of my favorite examples is **Unwyned**, a wine rating app for normal people. It’s the kind of project I’ve wanted to make for about a decade: something that feels approachable, fun, and actually useful, not a pretentious spreadsheet disguised as an app.

Agentic AI didn’t magically “finish it for me,” but it changed the math. A project that used to feel like it required perfect conditions and uninterrupted weekends can now move forward in smaller bursts. Ten minutes becomes meaningful. An afternoon becomes a real milestone.

That shift is huge when your backlog of “I swear I’ll build this someday” ideas is measured in years.

## A new mindset: clone, tailor, own the workflow

Agentic AI also changed how I think about software I use.

If I find a GitHub project that is *almost* what I need, I’m increasingly likely to:

- clone it  
- add the features I actually want  
- adopt it as “my version”  
- maintain it myself  

And here’s the controversial part: it is often faster to do that than to open an issue and hope upstream agrees with my priorities.

This approach used to come with a penalty. Maintenance is real work. Dependencies drift. Small bugs pile up. You inherit the future.

Now, that penalty is lower because agents can shoulder a lot of the maintenance chores: dependency bumps, lint fixes, tests, keeping things tidy, even drafting PRs with clear diffs. It does not remove responsibility, but it changes the cost curve enough that “owning your fork” starts to feel practical.

If you want a *Tenet* analogy, it feels like inverting the usual relationship with open source. Instead of waiting on the timeline where your feature gets merged, you build the version of the tool you want to live in.

## The tool journey: from Copilot and Cursor to Claude Code

Like most people, I took the usual path:

- **Copilot** made the day-to-day friction drop.
- **Cursor** made it feel like the editor itself was becoming collaborative.
- **Codex** became my “second set of eyes” concept: a skeptical reviewer brain when I want critique, not momentum.
- **Claude Code** is where I’ve settled for primary work, because it fits how I build: plan, implement, verify, iterate.

The important part is not which tool “wins.” It’s that my workflow evolved from “help me type” into “help me run an engineering loop.”

## My current workflow: PASIV as the proving ground

Right now, the cleanest expression of my workflow lives in a project I think of as my operating system for building: **PASIV**.

PASIV is where I’ve been tightening the loop into something repeatable:

- **GitHub Projects** for visibility and sequencing  
- **Claude skills** for brainstorming and turning vague ideas into concrete tasks  
- **TDD where it makes sense**, or at least test-first thinking when the surface area is risky  
- **verification gates**: run the tests, run the checks, prove it works  
- **linting + formatting** so the repo stays sane even when velocity is high  
- **security hygiene**: secret scanning mindset, dependency awareness, and not trusting generated code just because it runs  
- **subagents** when the work benefits from parallel thinking (planner, implementer, reviewer)  

This is the part I’m most convinced about: agentic AI is not one magic bot. It’s a pipeline. A set of roles and checkpoints that keep you moving fast without drifting into chaos.

And yes, I’m sure this workflow will change in a month. That’s the point. Like any good system, it evolves.

## TARS: keeping my Claude chaos from becoming a paradox

Once you start building this way, you accumulate… stuff.

Skills. Agents. Commands. MCP servers. Hooks. Project-specific conventions. Little pieces of configuration that work great until you have ten projects and you cannot remember which one had the good “review checklist” and which one had the “safe refactor” profile.

So I built **TARS**, which is basically my configuration control center for Claude Code. It’s a desktop app for managing Claude resources across projects, with support for things like skills, agents, commands, hooks, MCP servers, plugins, and reusable profiles you can apply across multiple projects.

The name is not subtle. It’s a nod to **TARS from _Interstellar_**, because that’s exactly what I needed: a dependable co-pilot that keeps a complicated mission from turning into a pile of disconnected timelines.

## The shadow side: why “pure vibe-coding” can be dangerous

I love the speed. I love the empowerment. I also think parts of this trend are risky.

Two things make me nervous:

1. **Autonomous systems that can act in your environment without tight guardrails.** Tools in the “OpenClaw / Clawdbot” category can be amazing, but they raise the stakes. The more direct power you give an agent, the more you need real controls.

2. **People shipping production systems without security instincts.** Agentic AI will happily generate something that works. It will not automatically protect you from secrets in code, sloppy auth, vulnerable dependencies, or “it passed once on my laptop” testing. The tool can accelerate you into a wall.

My mantra stays simple: **vibe, verify, ship.**

Move fast, but put reality checks in the loop.

## The hobby that made me better at work

All of this started as personal fun: games with my kid, side projects, tools I wish existed, apps I’ve wanted to build for years.

But it’s quietly made me better at my day job too, because now I understand what these tools can actually do in practice, not in a vendor slide deck.

That changes the conversation inside a serious organization. It becomes less “AI, scary” and more “here’s what’s possible, here’s what’s safe, here’s what controls we need, and here’s the payoff.”

You don’t need to be reckless to push for progress. You just need to be informed.

## Punchier ending: the loop that changed everything

Here’s what surprised me most: agentic AI didn’t just make me faster.

It made me notice my own needs sooner, then actually do something about them. The app I wanted for ten years? Start it. The tool that almost fits? Fork it, tailor it, own it. The workflow that keeps projects sane? Build it, refine it, share it across everything.

If *Inception* is about planting an idea and watching it take root, that’s what happened to me. The idea wasn’t “AI can code.” The idea was “I can ship more of what I imagine, with fewer dead ends.”

So I’m going to keep doing what I’ve been doing: building in public, iterating aggressively, and tightening the guardrails as the velocity increases. The tools will change. The workflow will evolve. The projects will multiply.

But the loop stays the same:

**Vibe. Verify. Ship.**  
Then do it again, a little smarter, a little safer, and with a better story.

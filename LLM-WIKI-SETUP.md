# Building an LLM Wiki — setup & philosophy

A self-contained guide to standing up a personal (or team) knowledge base that
an LLM builds and maintains for you. No Obsidian required, no external
dependencies, no links to follow — everything you need is in this document.

Hand this file to a capable coding agent (Claude Code, or similar) and tell it:
*"Set up an LLM Wiki in this directory following this guide."* The agent figures
out the mechanics (embedding models, search tooling, ingest scripts) for the
local environment; this doc gives it the philosophy and the schema to follow.

---

## TL;DR

You keep a folder of plaintext markdown files. Raw source material goes in one
place and is never edited. The LLM reads those sources and writes a second layer
— an interlinked wiki of summaries, entity pages, concept pages, and synthesized
answers — and keeps it current. You curate and ask questions; the LLM does all
the bookkeeping. Over time the wiki becomes a compounding record of everything
you've fed it and everything you've figured out.

It is just markdown files in a directory. Any editor works. An LLM agent with
filesystem access is the only hard requirement.

---

## The philosophy — why do this at all

This pattern originates with Andrej Karpathy's "LLM Wiki" note (2026). The ideas
below are the load-bearing parts, embedded here so you don't need the original.

### 1. It inverts RAG: compile knowledge at ingest time, not query time

The common way to use an LLM over your documents is retrieval-augmented
generation (RAG): you dump files into a vector store, and at query time the
system retrieves the most similar chunks and stuffs them into the prompt. The
knowledge is never actually *integrated* — every query re-derives understanding
from scratch, from raw fragments, with no memory that the same question was
asked before.

The LLM Wiki flips this. When a new source arrives, the LLM does the work
**then**: it reads the source in full, extracts what matters, and integrates it
across existing pages — updating cross-references, reconciling or flagging
contradictions, refining summaries. Knowledge is *compiled once and kept
current* rather than *re-retrieved on every question*. The wiki, not the raw
corpus, becomes the thing you read and query.

| Aspect | Classical RAG | LLM Wiki |
|---|---|---|
| When the work happens | Query time | Ingest time |
| Knowledge accumulation | None — restarts each query | Compounds over time |
| Cross-references | Re-discovered each time | Persisted on the page |
| Human role | Upload + ask | Curate + direct |
| Setup cost | Low | Higher (schema, conventions) |
| Cost per source | Low | Medium (5–15 page edits) |
| Best at | Large unstructured corpora | Curated, evolving domain |

### 2. The wiki is a compounding artifact

Every source you ingest and every good answer you file back makes the wiki
richer and the *next* question easier to answer. A RAG index is static — it
knows exactly as much after 500 queries as after one. A wiki grows: connections
accumulate, syntheses build on syntheses. You are not maintaining a search
index; you are growing a second brain that remembers its own conclusions.

### 3. LLMs solve the problem that kills every human wiki

Wikis, Zettelkasten note systems, personal knowledge bases — they almost all
die the same death: **maintenance burden grows faster than the value returned.**
Keeping cross-links current, reconciling new information with old pages, filing
things consistently — the tedious part was never the reading or the thinking, it
was the *bookkeeping*. Humans run out of discipline. LLMs don't get bored and
the marginal cost of that bookkeeping approaches zero, so the wiki stays alive
and stays consistent. This is the single insight that makes the whole thing
work now when it didn't before.

### 4. Clean division of labor

> The human's job is to curate sources, direct the analysis, ask good
> questions, and think about what it all means. The LLM's job is everything
> else.

You decide what goes in and what's worth asking. The LLM summarizes,
cross-references, files, lints, and keeps the index current. Don't do the
bookkeeping yourself and don't let the LLM decide what's important — that
boundary is the whole design.

### 5. Lineage

The spiritual ancestor is Vannevar Bush's **Memex** (1945): a personal, curated
store of knowledge connected by associative trails. Bush's unsolved problem was
*who does the upkeep* — the trails and links a real person would never have time
to maintain. The LLM is the answer to that 80-year-old question.
**Zettelkasten** (small, densely interlinked notes) is the other precursor, and
it died of the same maintenance problem the LLM now removes.

---

## You do not need Obsidian

Karpathy's original setup paired an LLM with Obsidian as the viewer. **Obsidian
is optional and replaceable.** The vault is nothing but plaintext markdown files
in folders. What actually matters:

- **Markdown files** — portable, greppable, diffable, future-proof.
- **`[[wikilinks]]`** — these are just text. The LLM reads and writes them to
  express relationships; any tool (or no tool) can follow them. They don't
  require Obsidian; they're a convention, not a feature.
- **YAML frontmatter** — a metadata block at the top of each file. Also just
  text. Enables consistent filtering later if you ever add tooling.

Any editor, `grep`, and an LLM agent are sufficient. If you later want graph
views or fancy search, add a viewer then — but it is never a prerequisite.

---

## Architecture — three layers

1. **Raw sources** (`raw/`) — immutable input. Documents, transcripts, exports,
   pasted notes. The LLM **reads but never modifies** this layer. It's the
   ground truth you can always re-derive from.

2. **The wiki** (`wiki/`) — LLM-owned markdown. Source summaries, entity pages,
   concept pages, project pages, synthesized answers, plus an `index.md`
   catalog and a `log.md` history. The LLM writes and maintains everything here.

3. **The schema** (`AGENTS.md` and/or `CLAUDE.md` at the root) — the
   instruction file that tells the LLM how the wiki is structured and how to
   behave. This is *the* key configuration: it's what turns a generic chatbot
   into a disciplined wiki maintainer. It co-evolves with you as conventions
   settle.

---

## Directory layout

```
knowledge-vault/
├── AGENTS.md          # the schema / behavior spec (see below). CLAUDE.md can
│                      #   be a one-line pointer to this, or a copy.
├── index.md           # content catalog — read FIRST on any query
├── log.md             # append-only chronological record of operations
│
├── raw/               # immutable sources — LLM reads, never edits
│   ├── inbox/         #   drop zone for unprocessed material
│   ├── docs/          #   local documents (notes, exports, PDFs-as-text)
│   └── chats/         #   transcripts, if you ingest conversations
│
├── wiki/              # LLM-owned output
│   ├── sources/       #   one summary page per ingested source
│   ├── entities/      #   orgs, products, systems, places
│   ├── people/        #   people (subset of entities; volume earns its folder)
│   ├── concepts/      #   ideas, methods, frameworks, definitions
│   ├── projects/      #   one evergreen page per project/initiative
│   ├── synthesis/     #   filed-back answers, comparisons, derived insight
│   └── journal/       #   optional: periodic digests
│
└── templates/         # page skeletons to copy when starting a new page
```

Adapt folder names to the domain. The raw/wiki/schema split is the invariant;
the sub-folders are conventions you can bend.

---

## Conventions

- **Filenames**: kebab-case, descriptive. `payment-service.md`,
  `oauth-token-refresh.md`, `2026-07-08-incident-notes.md`.
- **Links**: `[[wiki/concepts/foo]]` (or short `[[foo]]` when unambiguous).
  Every entity/concept *mention* should be a link. If the target doesn't exist
  yet, create a stub (frontmatter + one-line summary) so the link resolves.
- **Frontmatter**: every page starts with a YAML block. Always bump `updated:`
  when you change a page. Minimal example:
  ```yaml
  ---
  type: concept          # source | entity | person | concept | project | synthesis
  name: OAuth Token Refresh
  tags: [auth, security]
  updated: 2026-07-08
  ---
  ```
- **Tags**: lowercase, kebab-case, used sparingly. Prefer wikilinks for
  relationships; use tags for cross-cutting themes.
- **Citations**: when a claim comes from a source, link it —
  `(see [[sources/incident-postmortem-2026-06]])`.
- **Inferences**: mark anything not directly grounded in a source or a
  statement from you: `> **Inference:** ...`. This keeps the LLM's guesses
  visibly separate from established fact.
- **Style**: pages are for skimming first. Lead with a summary. Write claims,
  not vibes; if something is uncertain, say so. Prefer many short interlinked
  pages over few long ones. Quote sparingly and attribute exactly.

---

## The three operations

### Ingest — process a new source

1. Read the source in full.
2. (Optional) Confirm the framing with the human before writing.
3. Create `wiki/sources/<slug>.md` — summary, key claims, notable quotes, open
   questions, links to the entities/concepts it touches.
4. Create or update a page for each significant entity, person, and concept.
5. **Cross-link aggressively** — every entity/concept mention becomes a link,
   and every entity/concept page references the sources it draws from. This
   cross-referencing *is the point*; skipping it hollows out the wiki.
6. If the new source contradicts an existing page, add a
   `## Contradictions / updates` note — don't silently overwrite. Flag the
   divergence for the human.
7. Update `index.md` (add new pages, adjust summaries).
8. Append a dated entry to `log.md`.

A single ingest typically touches 5–15 pages. That fan-out is expected.

### Query — answer a question

1. Read `index.md` first to find candidate pages.
2. Read them; follow wikilinks to gather context.
3. Answer with inline citations to wiki pages.
4. If the answer is non-trivial — a comparison, an analysis, a connection that
   wasn't already written down — **file it back** as a new `wiki/synthesis/`
   page. Good answers should not evaporate into chat history; they should
   compound like ingested sources do.
5. Log the query/synthesis in `log.md`.

### Lint — periodic health check

Walk the wiki and report (don't auto-fix without confirmation):
- Contradictions between pages.
- Stale claims that newer sources superseded.
- Orphan pages (nothing links to them).
- Concepts/entities mentioned in prose but lacking their own page.
- Missing cross-references (a page names X but doesn't link `[[X]]`).
- Pages with missing or outdated frontmatter.
- Gaps that suggest a useful next source to acquire.

---

## Retrieval: why `index.md` replaces embeddings (at first)

The instinct is to reach for a vector database immediately. You usually don't
need one. At moderate scale — roughly up to a few hundred pages — a well-
maintained `index.md` catalog plus the directory structure *is* your retrieval
system. The LLM reads the index, picks the relevant pages, and follows links.
No embedding infrastructure, no similarity search, no moving parts.

Add embedding-based search only when browsing the index becomes the actual
bottleneck — i.e. when the LLM can no longer reliably find the right page from
the catalog alone. When that day comes, the right shape is a **search tool the
LLM calls** (a local markdown search over the vault — keyword/BM25 first, vector
search layered in if needed), exposed to the agent rather than bolted in front
of it. The wiki stays the source of truth; search is just a faster way in.

> If embedding models are available in your environment, they slot in *here* —
> as an optional retrieval accelerator over the finished wiki — not as a
> replacement for the compile-at-ingest philosophy. Build the wiki first; add
> search when scale forces it.

---

## The schema file — the one thing to get right

`AGENTS.md` (and a `CLAUDE.md` that points to or copies it) is the contract. It
should state, in plain language:

- **What this vault is** and the raw/wiki/schema layering.
- **The layout table** — every folder, who owns it, what goes there.
- **The conventions** — filenames, wikilinks, frontmatter fields, tags,
  citation and inference marking.
- **The three workflows** — ingest, query, lint — as explicit steps.
- **The log format** — a parseable dated header so history stays greppable, e.g.
  `## [YYYY-MM-DD] <type> | <title>`.
- **What the LLM must NOT do** — never modify `raw/`, never fabricate the
  human's opinions, never write ungrounded claims without marking them as
  inferences, never delete pages without asking (mark superseded instead).

Treat this file as living configuration. When you notice the LLM drifting
(stops cross-linking, files things inconsistently), the fix is almost always to
sharpen the schema, not to correct pages one by one.

---

## Bootstrap checklist (hand to the agent)

1. Create the directory skeleton above.
2. Write `AGENTS.md` from the schema section — adapt folder names to the domain.
   Add a one-line `CLAUDE.md` pointing at it if using Claude Code.
3. Create empty `index.md` and `log.md` with headers.
4. Add a few `templates/` page skeletons (source, entity, concept, project,
   synthesis) so new pages start consistent.
5. Drop the first real source into `raw/inbox/` and run one full **ingest** end
   to end — this shakes out the conventions faster than any amount of planning.
6. Ask one real **query** and file the answer back as synthesis — confirm the
   compounding loop works.
7. Only after the wiki has real content, decide whether search tooling /
   embeddings are warranted. Usually: not yet.

---

## Starter prompt for the agent

> Read `LLM-WIKI-SETUP.md`. Set up an LLM Wiki in this directory following it:
> create the folder skeleton, write an `AGENTS.md` schema adapted to
> [describe the domain], and seed `index.md`, `log.md`, and `templates/`. Then
> stop and show me the structure before we ingest anything. You own everything
> under `wiki/`; you never edit `raw/`. Cross-link aggressively and mark any
> ungrounded claim as an inference.

---

*The mechanics (scripts, search, embeddings, viewers) are environment-specific
and safe to figure out locally. The philosophy above is the part that
transfers: compile knowledge at ingest time, let the LLM own the bookkeeping,
and let the wiki compound.*

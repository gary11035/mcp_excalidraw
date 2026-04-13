---
name: excalidraw-skill
description: Programmatic canvas toolkit for creating, editing, and refining Excalidraw diagrams via MCP tools with real-time canvas sync. Use when an agent needs to (1) draw or lay out diagrams on a live canvas, (2) iteratively refine diagrams using describe_scene and get_canvas_screenshot to see its own work, (3) export/import .excalidraw files or PNG/SVG images, (4) save/restore canvas snapshots, (5) convert Mermaid to Excalidraw, or (6) perform element-level CRUD, alignment, distribution, grouping, duplication, and locking. Requires a running canvas server (EXPRESS_SERVER_URL, default http://localhost:3000).
---

# Excalidraw Skill

## Step 0: Determine Connection Mode

Two modes are available. Try MCP first — it has more capabilities.

**MCP mode** (preferred): If `excalidraw/batch_create_elements` and other `excalidraw/*` tools appear in your tool list, use them directly. MCP tools handle label and arrow binding format automatically.

**REST API mode** (fallback): If MCP tools aren't available, use HTTP endpoints at `http://localhost:3000`. See the cheatsheet for REST payloads. Note the format differences in the table below — REST and MCP accept slightly different field names.

**Neither works?** Tell the user:
> The Excalidraw canvas server is not running. To set up:
> 1. `git clone https://github.com/yctimlin/mcp_excalidraw && cd mcp_excalidraw`
> 2. `npm ci && npm run build`
> 3. `PORT=3000 npm run canvas`
> 4. Open `http://localhost:3000` in a browser
> 5. (Recommended) Install the MCP server:
>    `claude mcp add excalidraw -s user -e EXPRESS_SERVER_URL=http://localhost:3000 -- node /path/to/mcp_excalidraw/dist/index.js`

### MCP vs REST API Quick Reference

| Operation | MCP Tool | REST API Equivalent |
|-----------|----------|-------------------|
| Create elements | `batch_create_elements` | `POST /api/elements/batch` |
| Get all elements | `query_elements` | `GET /api/elements` |
| Get one element | `get_element` | `GET /api/elements/:id` |
| Update element | `update_element` | `PUT /api/elements/:id` |
| Delete element | `delete_element` | `DELETE /api/elements/:id` |
| Clear canvas | `clear_canvas` | `DELETE /api/elements/clear` |
| Describe scene | `describe_scene` | `GET /api/elements` (parse manually) |
| Export scene | `export_scene` | `GET /api/elements` (save to file) |
| Import scene | `import_scene` | `POST /api/elements/sync` |
| Snapshot | `snapshot_scene` | `POST /api/snapshots` |
| Restore snapshot | `restore_snapshot` | `GET /api/snapshots/:name` then `POST /api/elements/sync` |
| Screenshot | `get_canvas_screenshot` | `POST /api/export/image` (needs browser) |
| Viewport | `set_viewport` | `POST /api/viewport` (needs browser) |
| Export image | `export_to_image` | `POST /api/export/image` (needs browser) |
| Export URL | `export_to_excalidraw_url` | Only via MCP |

### Format Differences Between Modes (Critical)

1. **Labels**: MCP accepts `"text": "My Label"` on shapes (auto-converts). REST requires `"label": {"text": "My Label"}`.
2. **Arrow binding**: MCP accepts `startElementId`/`endElementId`. REST requires `"start": {"id": "..."}` / `"end": {"id": "..."}`.
3. **fontFamily**: Must be a string (e.g. `"1"`) or omit entirely. Never pass a number.
4. **Updating labels via REST**: Re-include `"label"` in the PUT body to ensure it renders correctly after updates.

---

## Language Rule (MANDATORY)

**All diagram text MUST be written in Traditional Chinese (繁體中文).** This applies to:

- Diagram title and subtitle
- Section labels (layer names, group names)
- Node titles and node descriptions
- Arrow labels
- Core insight callout text
- Annotations and credits

**Only keep in English when:**
- The term is a proper technical identifier that must not be translated (e.g., file names: `main.py`, `rag_utils.py`; API paths: `/v1/chat/completions`; library names: `FastAPI`, `OpenAI`)
- The original source uses an English acronym as a fixed term (e.g., `RAG`, `SSE`, `MCP`)

For all other content — labels, descriptions, insights, section names — use 繁體中文.

---

## Design Philosophy

You are not "drawing a diagram." You are **re-encoding information architecture**. A linear document has one reading path; a structural diagram has simultaneous visual entry points. Your job is to make the reader grasp in 10 seconds what took 10 minutes to read.

**Three governing principles:**

1. **One diagram, one question.** Each diagram answers exactly one cognitive question: "What is it made of?" (architecture), "Why does it work?" (methodology), or "How is it different?" (comparison). Never mix these.
2. **Content determines form.** The type of information dictates the visual structure. Do not pick a chart type first and force content into it.
3. **Abstraction ladder.** Source documents live at implementation level (code, schemas, CLI commands). Diagrams must climb to concept level (knowledge model, data flow pattern, design tradeoffs). Strip away implementation details; preserve design intent.

**The Isomorphism Test:** If you removed all text, would the structure alone communicate the concept? If not, redesign.

**The Education Test:** Could someone learn something concrete from this diagram, or does it just label boxes? A good diagram teaches — it shows actual formats, real event names, concrete examples.

---

## Diagram Type Decision Tree

Before drawing, decide which diagram type answers the source content's core question:

```
What does the source content describe?
│
├─ A system with parts that depend on each other
│  → Layered Architecture (top=consumer, bottom=storage)
│  → Question: "What is it made of?"
│
├─ A philosophy or framework with parallel concepts
│  → Concept Grid (2–4 columns, each a category)
│  → Question: "Why does it work this way?"
│
├─ Two or more alternatives evaluated on dimensions
│  → Comparison Matrix (Side A vs Side B + verdict tags)
│  → Question: "How is it different from X?"
│
├─ A sequence of steps with decisions
│  → Flowchart (horizontal flow, diamond for decisions)
│  → Question: "What happens when X is triggered?"
│
└─ A mix of structure + process
   → Sidebar Composition (left 60% architecture + right 40% process)
   → Question: "What is it and how does it work?"
```

**Pre-drawing analysis — do this in order:**

1. Mark every section of the source that answers one of the five questions above.
2. Each cognitive question becomes one diagram (a typical technical spec produces 2–4).
3. Extract: **Nouns** → nodes, **Verbs/relationships** → arrows, **Categories** → color groups, **Hierarchies** → spatial position.
4. Decide if simple/conceptual (abstract shapes) or comprehensive/technical (concrete examples, real data).

---

## Layout Patterns (A–E)

Choose the pattern that matches your diagram type from the Decision Tree above.

#### Pattern A — Layered Stack (for architecture)

```
┌─────────────────────────────────────────┐
│           Section Label (colored)        │
│  ┌──────┐  ┌──────┐  ┌──────┐           │
│  │ Node │  │ Node │  │ Node │           │
│  └──┬───┘  └──┬───┘  └──┬───┘           │
│     │         │         │                │
│     └─────────┼─────────┘                │
│               ▼                          │
│           Section Label                  │
│  ┌──────┐  ┌──────┐  ┌──────┐           │
│  │ Node │  │ Node │  │ Node │           │
│  └──────┘  └──────┘  └──────┘           │
└─────────────────────────────────────────┘
```

- Top = consumers / callers. Bottom = storage / foundation.
- Nodes at the same layer are placed horizontally.
- Arrows flow downward (dependency direction).
- Horizontal spacing is even; nodes in a row share the same height.

#### Pattern B — Concept Grid (for methodology / framework)

```
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  Category A  │  │  Category B  │  │  Category C  │
│              │  │              │  │              │
│  ┌────────┐  │  │  ┌────────┐  │  │  ┌────────┐  │
│  │ Item 1 │  │  │  │ Item 1 │  │  │  │ Item 1 │  │
│  ├────────┤  │  │  ├────────┤  │  │  ├────────┤  │
│  │ Item 2 │  │  │  │ Item 2 │  │  │  │ Item 2 │  │
│  └────────┘  │  │  └────────┘  │  │  └────────┘  │
└──────────────┘  └──────────────┘  └──────────────┘
```

- 2–4 columns, each a conceptual category.
- Each column has a colored header and 2–4 child items.
- No arrows between columns unless there is a direct dependency.
- Spatial proximity = conceptual proximity.

#### Pattern C — Comparison Matrix (for versus / evaluation)

```
         ┌── Side A ──┐     ┌── Side B ──┐   Verdict
Dim 1    │ description │     │ description │   [tag]
Dim 2    │ description │     │ description │   [tag]
Dim 3    │ description │     │ description │   [tag]
         ┌─ When A... ─┐     ┌─ When B... ─┐
         │ criteria     │     │ criteria     │
         └──────────────┘     └──────────────┘
┌──────────── Meta-verdict (full width, warm yellow) ─────────────┐
```

- **Left column** = dimension labels (free-floating colored text, no container).
- **Center two columns** = description cells, colored by side (Side A = purple, Side B = green).
- **Verdict tags** = small rounded rectangles (~80×28px): 平局→`#FFF3CC`, Side A wins→`#d1c4e9`, Side B wins→`#c8e6c9`.
- **Final row** = meta-insight callout, full width, `#fff3cd` background.

#### Pattern D — Flowchart (for processes)

```
[Start] ──→ [Step 1] ──→ [Step 2] ──→ ◇ Decision?
                                        │ Yes    │ No
                                        ▼        ▼
                                   [Path A]  [Path B]
                                        │        │
                                        └───┬────┘
                                            ▼
                                       [Outcome]
```

- Horizontal flow for linear sequences.
- Diamond for decisions with labeled Yes/No branches.
- Converge paths back to a single outcome node.
- Terminal nodes (outcomes) use ellipse shape with accent color.

#### Pattern E — Sidebar Composition (structure + behavior)

When a single diagram needs to show both structure and behavior:
- **Left 60%** = static architecture (Pattern A)
- **Right 40%** = dynamic processes (Pattern D or concept map)

Separate the two halves with whitespace, not a line. They share the same color system.

---

## Color System (Nash Palette)

**Rule: Each color = one semantic category. Assign at the start, never reassign.**

```
Layer / Category            Fill        Stroke / Text
────────────────────────────────────────────────────────
消費層 Consumer/external    #b2ebf2     #00838f   (teal)
介面層 Interface/API        #d1c4e9     #512da8   (purple)
核心庫 Core logic           #c8e6c9     #2e7d32   (mint green)
存儲層 Storage/data         #dcedc8     #558b2f   (light olive)
技能層 Skills               #ffe0b2     #e65100   (peach/orange)
流程步驟 Process steps      #f8bbd0     #880e4f   (coral pink)
結果/高亮 Result            #b2dfdb     #00695c   (mint teal)
決策 Decision               #fff9c4     #f57f17   (light gold)
AI/LLM (special)            #e8d5fe     #6d28d9   (lavender)
核心洞察 Core insight       #fff3cd     #856404   (warm yellow)
```

- **Accent trigger rule:** The single most important entry point MAY use a high-saturation ellipse (`#FFB300` gold fill, `#E65100` stroke). Limit to **one** per diagram.
- **Saturation rule:** All other fills stay pastel. The accent ellipse is the only exception.
- **Text color follows fill:** Use the darker stroke color of each row as text color. Never black `#000000` on colored fills.
- **Max 5 semantic colors per diagram.** If you need more, the diagram is doing too much — split it.

---

## Typography Hierarchy

```
Level 1 — Diagram title      fontSize: 28, centered, color: #1e40af
Level 2 — Subtitle           fontSize: 16, gray (#888888), one line below title
Level 3 — Section labels     fontSize: 14, colored text matching section hue, left-aligned, no container
Level 4 — Node titles        fontSize: 14–16, inside boxes (first line = title)
Level 5 — Node descriptions  fontSize: 12–13, inside boxes below title
Level 6 — Annotations        fontSize: 11, gray (#888888), outside boxes
Core insight callout         fontSize: 15–16, bold key sentence + normal explanation lines
```

**Font:** Use `fontFamily: 1` (Virgil — Excalidraw 手寫字體) for ALL text elements. This gives diagrams a personal, sketch-quality feel rather than a printed document look. Single font family throughout — title uses larger `fontSize` only, no separate display font needed.

**Dynamic Font Scaling:** Adjust `fontSize` (11, 12, 13, 14...) so text looks "full" inside its container with appropriate margins, not leaving huge empty spaces.

---

## Text Writing Inside Nodes

**A box without text is a colored rectangle. A box with text is knowledge.** Every node MUST contain text. No exceptions.

### Node Anatomy

Every node has exactly two text layers:

```
┌──────────────────────────────────────┐
│  Title (larger font, first line)     │
│  Description line 1                  │
│  Description line 2                  │
│  Description line 3 (max)            │
└──────────────────────────────────────┘
```

- **Title** = WHAT it is. The name. 1–5 words.
- **Description** = WHY it matters or WHAT it does. 1–3 lines of sentence fragments.

Both are mandatory. A node with only a title is incomplete.

### Five Description Patterns (pick the one that fits)

**Pattern 1 — Role statement** (components): Verb-first fragments stating what it does.
```
FastAPI 路由層
接收 HTTP 請求
驗證 token / 轉發
回傳 JSON 回應
```

**Pattern 2 — Bullet-style properties** (concepts): 2–4 key properties using slashes.
```
RAG 檢索策略
語義向量 / 關鍵字 FTS5
Top-K 合併後重排
超出 token 限制則截斷
```

**Pattern 3 — Input → Output** (process steps): Arrow notation within text.
```
向量嵌入
文字 → OpenAI Embedding API
→ 1536 維向量儲存 Qdrant
→ cosine similarity 查詢
```

**Pattern 4 — Contrast pair** (comparison cells): Key fact + implication.
```
Markdown 文件目錄
Git-friendly，人類可讀
修改版本完整可追蹤
```

**Pattern 5 — Enumeration** (leaf nodes listing members):
```
日誌分類
ERROR / WARNING / INFO
QUERY / RESPONSE / SYSTEM
```

### Text Density Rules

| Node type | Title | Description | Lines |
|-----------|:-----:|:-----------:|:-----:|
| Architecture component | YES | YES | 1–2 |
| Concept / model | YES | YES | 2–4 |
| Process step | YES | YES | 1–2 |
| Comparison cell | YES | YES | 2 (fact + implication) |
| Decision diamond | YES (the question) | NO | 0 |
| Core insight callout | NO | YES — the insight IS the text | 1–3 sentences |

**Balance rule:** If any node in a group has a description, ALL nodes in that group must have descriptions.

### Text Formatting Rules

- **No markdown syntax** inside text. No `**bold**`, no `- bullets`, no `1. numbered`.
- Slashes for alternatives: `搜索/綜合/引用`
- Arrow notation for flow: `source → LLM → wiki pages`
- Parenthetical clarifiers: `MCP Server (stdio)`, `brain.db (SQLite)`
- Each line is one thought. Do not wrap a single thought across two lines.

### Section Labels (text outside nodes)

Every layer or group needs a **section label** — colored text placed above-left of the group, matching the group's hue:

```
消費層                          ← section label (teal text, no box)
┌──────────┐  ┌──────────┐
│ 服務 A   │  │  服務 B  │    ← nodes (teal fill)
└──────────┘  └──────────┘

介面層                          ← section label (purple text)
┌────────────────┐
│ MCP Server     │
│ stdio transport│
└────────────────┘
```

Section labels are **NOT** inside boxes. They float as standalone colored text and serve as the reader's navigation landmark.

### Diagram Title and Subtitle

```
       X-Pert 整體架構                        ← Level 1: large, color #1e40af
FastAPI · Qdrant · SQLite · MCP Server       ← Level 2: smaller, gray #888888
```

- **Title:** `[Subject] [Diagram Type]` — e.g. "X-Pert 整體架構", "RAG 方法論".
- **Subtitle:** A one-line tech stack summary using middle-dot (·) as separator.
- Together they answer: "What am I looking at, and what world does it belong to?"

### The "No Empty Box" Test

After placing all nodes, run this test:
1. Point to each box in the diagram.
2. Read only the text inside that box.
3. Ask: "Do I know what this is and why it exists?"
4. If no → add description lines.
5. If you cannot write a description → this node is at the wrong abstraction level or should not be a separate node.

**A diagram full of colored rectangles without text is a wireframe, not a concept visualization.**

---

## Abstraction Rules

Source documents live at **implementation level** (code, schemas, CLI commands). Diagrams must climb to **concept level** (knowledge model, data flow pattern, design tradeoffs). Strip away implementation details; preserve design intent.

### Translation Table

| Source (implementation) | Diagram (concept) |
|---|---|
| SQL schema with 9 tables | "Storage layer: brain.db" with table names as small nodes |
| 500 lines of TypeScript in 5 files | "Core library" with file names as small nodes |
| 15-step CLI command reference | "Interface layer" with two nodes: "MCP Server" + "CLI" |
| Detailed ranking formula (FTS5 × 0.4 + vector × 0.6) | Flowchart: "FTS5 Keywords" + "Vector Semantic" → merge → result |
| 7-paragraph design rationale | One callout box with the core sentence |
| Code example with 30 lines | Omit entirely. Not for this medium. |

### What to Cut

- Code snippets — always omit
- Configuration examples — always omit
- Step-by-step instructions — compress to 3–5 flow nodes maximum
- Error handling / edge cases — omit
- Version numbers / dependencies — omit unless they are the point

### What to Promote

- Design tradeoffs (Why X over Y?) → becomes a comparison row or callout
- Naming conventions → becomes a legend or inline label
- The "core insight" paragraph (every good spec has one) → becomes the bottom callout box

---

## Coordinate System

The canvas uses a 2D coordinate grid: **(0, 0) is the origin**, **x increases rightward**, **y increases downward**. Plan your layout before writing any JSON.

**General spacing guidelines:**
- Vertical spacing between tiers: 80–120px (enough that arrows don't crowd labels)
- Horizontal spacing between siblings: 40–60px minimum
- Shape width: `max(160, labelCharCount * 9)` to prevent text truncation
- Shape height: 60px single-line, 80px two-line labels
- Background/zone padding: 50px on all sides around contained elements

**Spatial semantics:**

| Position | Meaning |
|----------|---------|
| Top | Consumers, callers, external-facing |
| Bottom | Storage, foundation, infrastructure |
| Left | Primary / main path |
| Right | Secondary / supplementary info / sidebar |
| Center | Core, the thing everything connects to |
| Bottom-center | Core insight / meta-conclusion callout |
| Bottom-right | Credits, authorship |

**Whitespace = Importance:** The most important element has the most empty space around it. Dense clusters indicate a logical unit. Space between clusters indicates a boundary.

---

## Layout Anti-Patterns (Critical for Complex Diagrams)

These are the most common mistakes that produce unreadable diagrams. Avoid all of them.

### 1. Do NOT use `label.text` (or `text`) on large background zone rectangles

When you put a label on a background rectangle, Excalidraw creates a bound text element centered in the middle of that shape — right where your service boxes will be placed. The text overlaps everything inside the zone and cannot be repositioned.

**Wrong:**
```json
{"id": "vpc-zone", "type": "rectangle", "x": 50, "y": 50, "width": 800, "height": 400, "text": "VPC (10.0.0.0/16)"}
```

**Right — use a free-standing text element anchored at the top of the zone:**
```json
{"id": "vpc-zone", "type": "rectangle", "x": 50, "y": 50, "width": 800, "height": 400, "backgroundColor": "#e3f2fd"},
{"id": "vpc-label", "type": "text", "x": 70, "y": 60, "width": 300, "height": 30, "text": "VPC (10.0.0.0/16)", "fontSize": 18, "fontWeight": "bold"}
```

The free-standing text element sits at the top corner of the zone and doesn't interfere with elements placed inside.

### 2. Avoid cross-zone arrows in complex diagrams

An arrow from an element in one layout zone to an element in a distant zone will draw a long diagonal line crossing through everything in between. In a multi-zone infra diagram this produces an unreadable tangle of spaghetti.

**Design rule:** Keep arrows within the same zone or tier. To show cross-zone relationships, use annotation text or separate the zones so their edges are adjacent (no elements between them), and route the arrow along the edge.

If you must connect across zones, use an elbowed arrow that travels along the perimeter — never through the middle of another zone.

### 3. Use arrow labels sparingly

Arrow labels are placed at the midpoint of the arrow. On short arrows, they overlap the shapes at both ends. On crowded diagrams, they collide with nearby elements.

- Only add an arrow label when the relationship name is genuinely essential (e.g., protocol, port number, data direction).
- If you're adding a label to every arrow, reconsider — it usually adds visual noise, not clarity.
- Keep arrow labels to ≤ 12 characters. Prefer omitting them entirely on dense diagrams.

### 4. Other common mistakes

| Mistake | Why it fails | Fix |
|---------|-------------|-----|
| **Empty boxes / title-only nodes** | Colored rectangles without text are meaningless shapes. | Every node gets a title + 1–3 description lines. |
| Using 6+ colors | Reader can't decode the color system. | Max 5 semantic colors per diagram. |
| Arrows everywhere | Spaghetti. Reader gives up. | Use spatial grouping for "belongs to" instead of arrows. |
| Everything the same size | No hierarchy signal. | Key nodes larger; leaf nodes smaller. |
| Missing section labels | Reader can't tell which group a node belongs to. | Add colored text label (no box) above-left of every cluster. |
| Missing diagram title | Reader has no entry point. | Always start with large title + one-line gray subtitle. |

---

## Quality: Why It Matters (and How to Check)

Excalidraw diagrams are visual communication. If text is cut off, elements overlap, or arrows cross through unrelated shapes, the diagram becomes confusing and unprofessional — it defeats the whole purpose of drawing it. So after every batch of elements, verify before adding more.

### Quality Checklist

After each `batch_create_elements` / `POST /api/elements/batch`, take a screenshot and check:

1. **Text truncation** — Is all label text fully visible? Truncated text means the shape is too small. Increase `width` and/or `height`.
2. **Overlap** — Do any shapes share the same space? Background zones must fully contain children with padding.
3. **Arrow crossing** — Do arrows cut through unrelated elements? If yes, route them around using curved or elbowed arrows (see Arrow Routing below).
4. **Arrow-label overlap** — Arrow labels sit at the midpoint. If they overlap a shape, shorten the label or adjust the arrow path.
5. **Spacing** — At least 40px gap between elements. Cramped layouts are hard to read.
6. **Readability** — Font size ≥ 16 for body text, ≥ 20 for titles.
7. **Zone label placement** — If you used `text`/`label.text` on a background zone rectangle, the zone label will be centered in the middle of the zone, overlapping everything inside. Fix: delete the bound text element and add a free-standing text element at the top of the zone instead (see Layout Anti-Patterns above).
8. **No empty boxes** — Point to each box. Read only the text inside. Ask: "Do I know what this is and why it exists?" If no → add description lines.

If you find any issue: **stop, fix it, re-screenshot, then continue.** Say "I see [issue], fixing it" rather than glossing over problems. Only proceed once all checks pass.

---

## Workflow: Drawing a New Diagram

### Mermaid vs. Direct Creation — Which to Use?

**Use `create_from_mermaid`** when: the user already has a Mermaid diagram, or the structure maps cleanly to a flowchart/sequence/ER diagram with standard Mermaid syntax. It's fast and handles conversion automatically, though you get less control over exact layout.

**Use `batch_create_elements` directly** when: you need precise layout control, the diagram type doesn't map to Mermaid well (e.g., custom architecture, annotated cloud diagrams), or you want elements positioned in a specific coordinate grid.

### MCP Mode

1. Call `read_diagram_guide` for design best practices (colors, fonts, anti-patterns).
2. **Run the Decision Tree** (see above) — decide what type of diagram and how many.
3. Plan your coordinate grid on paper/in comments — map out tiers and x-positions before writing JSON.
4. Optional: `clear_canvas` to start fresh.
5. Use `batch_create_elements` — create shapes and arrows in one call. Custom `id` fields (e.g. `"id": "auth-svc"`) make later updates easy.
6. Set shape widths using `max(160, labelLength * 9)`. Use `text` field for labels.
7. Bind arrows with `startElementId` / `endElementId` — they auto-route to element edges.
8. `set_viewport` with `scrollToContent: true` to auto-fit.
9. `get_canvas_screenshot` → run Quality Checklist → fix issues before next iteration.

**MCP element + arrow example:**
```json
{"elements": [
  {"id": "lb", "type": "rectangle", "x": 300, "y": 50, "width": 180, "height": 60, "text": "負載均衡器\nNginx / 443", "backgroundColor": "#b2ebf2"},
  {"id": "svc-a", "type": "rectangle", "x": 100, "y": 200, "width": 160, "height": 60, "text": "Web Server 1\nPort 8080", "backgroundColor": "#c8e6c9"},
  {"id": "svc-b", "type": "rectangle", "x": 450, "y": 200, "width": 160, "height": 60, "text": "Web Server 2\nPort 8080", "backgroundColor": "#c8e6c9"},
  {"id": "db", "type": "rectangle", "x": 275, "y": 350, "width": 210, "height": 60, "text": "PostgreSQL\n主資料庫 / Port 5432", "backgroundColor": "#dcedc8"},
  {"type": "arrow", "x": 0, "y": 0, "startElementId": "lb", "endElementId": "svc-a"},
  {"type": "arrow", "x": 0, "y": 0, "startElementId": "lb", "endElementId": "svc-b"},
  {"type": "arrow", "x": 0, "y": 0, "startElementId": "svc-a", "endElementId": "db"},
  {"type": "arrow", "x": 0, "y": 0, "startElementId": "svc-b", "endElementId": "db"}
]}
```

### REST API Mode

1. Plan your coordinate grid first.
2. Optional: `curl -X DELETE http://localhost:3000/api/elements/clear`
3. Create elements using `POST /api/elements/batch`. Use `"label": {"text": "..."}` for labels.
4. Bind arrows with `"start": {"id": "..."}` / `"end": {"id": "..."}`.
5. Verify with `POST /api/export/image` → save PNG → run Quality Checklist.

**REST API element + arrow example:**
```bash
curl -X POST http://localhost:3000/api/elements/batch \
  -H "Content-Type: application/json" \
  -d '{
    "elements": [
      {"id": "svc-a", "type": "rectangle", "x": 100, "y": 100, "width": 160, "height": 60, "label": {"text": "服務 A"}},
      {"id": "svc-b", "type": "rectangle", "x": 400, "y": 100, "width": 160, "height": 60, "label": {"text": "服務 B"}},
      {"type": "arrow", "x": 0, "y": 0, "start": {"id": "svc-a"}, "end": {"id": "svc-b"}, "label": {"text": "呼叫"}}
    ]
  }'
```

---

## Arrow Routing — Avoid Overlaps

Straight arrows can cross through elements in complex diagrams. Use curved or elbowed arrows when needed:

**Curved arrows** (smooth arc over obstacles):
```json
{
  "type": "arrow", "x": 100, "y": 100,
  "points": [[0, 0], [50, -40], [200, 0]],
  "roundness": {"type": 2}
}
```
The intermediate waypoint `[50, -40]` lifts the arrow upward. `roundness: {type: 2}` makes it smooth.

**Elbowed arrows** (right-angle / L-shaped routing):
```json
{
  "type": "arrow", "x": 100, "y": 100,
  "points": [[0, 0], [0, -50], [200, -50], [200, 0]],
  "elbowed": true
}
```

**When to use which:**
- Fan-out (one source → many targets): curved arrows with waypoints spread to avoid overlapping
- Cross-lane (connecting to side panels): elbowed arrows that go up, then across, then down
- Long horizontal connections: curved arrows with a slight vertical offset

**Rule:** If an arrow would pass through an unrelated shape, add a waypoint to route around it.

**Points format**: Both `[[x, y], ...]` tuples and `[{"x": ..., "y": ...}]` objects are accepted; both are normalized automatically.

---

## Workflow: Iterative Refinement

Using `describe_scene` and `get_canvas_screenshot` together is what makes this skill powerful.

- **`describe_scene`** → returns structured text: element IDs, types, positions, labels, connections. Use this when you need to know *what's on the canvas* before making programmatic updates (find IDs, understand bounding boxes).
- **`get_canvas_screenshot`** → returns a PNG image of the actual rendered canvas. Use this for *visual quality verification* — it shows you exactly what the user sees, including truncation, overlap, and arrow routing.

**Feedback loop (MCP):**
```
batch_create_elements
  → get_canvas_screenshot → "text truncated on auth-svc"
  → update_element (increase width) → get_canvas_screenshot → "overlap between auth-svc and rate-limiter"
  → update_element (reposition) → get_canvas_screenshot → "all checks pass"
  → proceed
```

**Feedback loop (REST):**
```
POST /api/elements/batch
  → POST /api/export/image → save PNG → evaluate
  → PUT /api/elements/:id (fix issues) → re-screenshot → evaluate
  → proceed
```

---

## Workflow: Refine an Existing Diagram

1. `describe_scene` to understand current state — note element IDs and positions.
2. Identify elements by `id` or label text (not by x/y coordinates — they change).
3. `update_element` to resize/recolor/move; `delete_element` to remove.
4. `get_canvas_screenshot` to confirm the change looks right.
5. If updates fail: check the ID exists with `get_element`; check it's not locked with `unlock_elements`.

---

## Workflow: Mermaid Conversion

For converting existing Mermaid diagrams to Excalidraw:

**MCP mode:**
```
create_from_mermaid(mermaidDiagram: "graph TD\n  A --> B\n  B --> C")
```
After conversion, call `set_viewport` with `scrollToContent: true` and `get_canvas_screenshot` to verify layout. If the auto-layout is poor (nodes crowded, edges crossing), identify problem elements with `describe_scene` and reposition with `update_element`.

**REST mode:**
```bash
curl -X POST http://localhost:3000/api/elements/from-mermaid \
  -H "Content-Type: application/json" \
  -d '{"mermaid": "graph TD\n  A --> B\n  B --> C"}'
```

---

## Workflow: File I/O

- Export to `.excalidraw`: `export_scene` with optional `filePath`
- Import from `.excalidraw`: `import_scene` with `mode: "replace"` or `"merge"`
- Export to image: `export_to_image` with `format: "png"` or `"svg"` (requires browser open)
- Share link: `export_to_excalidraw_url` — encrypts scene, returns shareable excalidraw.com URL
- CLI export: `node scripts/export-elements.cjs --out diagram.elements.json`
- CLI import: `node scripts/import-elements.cjs --in diagram.elements.json --mode batch|sync`

## Workflow: Snapshots

1. `snapshot_scene` with a name before risky changes.
2. Make changes, evaluate with `describe_scene` / `get_canvas_screenshot`.
3. `restore_snapshot` to roll back if needed.

## Workflow: Duplication

`duplicate_elements` with `elementIds` and optional `offsetX`/`offsetY` (default: 20, 20). Useful for repeated patterns or copying layouts.

---

## Multi-Diagram Set Rules

When producing 2+ diagrams from the same source:

1. **Shared color assignments.** If "core library" is green in Diagram 1, it stays green in Diagram 2.
2. **Escalating abstraction.** Diagram 1 = architecture (most concrete). Diagram 2 = methodology (more abstract). Diagram 3 = comparison (most evaluative).
3. **Consistent title format.** `[Subject] [Diagram Type]` — e.g. "X-Pert 整體架構", "RAG 方法論", "方案 A vs 方案 B 對比".
4. **Consistent subtitle.** One-line tech stack summary using middle-dot (·) separator.
5. **Same canvas proportions.** All diagrams use roughly the same width:height ratio (16:9 landscape preferred).

---

## Error Recovery

- **Elements not appearing?** Check `describe_scene` — they may have been created off-screen. Use `set_viewport` with `scrollToContent: true`.
- **Arrow not connecting?** Verify element IDs with `get_element`. Make sure `startElementId`/`endElementId` (MCP) or `start.id`/`end.id` (REST) match existing element IDs.
- **Canvas in a bad state?** `snapshot_scene` first, then `clear_canvas` and rebuild. Or `restore_snapshot` to go back.
- **Element won't update?** It may be locked — call `unlock_elements` first.
- **Layout looking wrong after import?** Use `describe_scene` to inspect actual positions, then batch-update positions.
- **Duplicate text elements / element count doubling?** The frontend has an auto-sync timer that periodically sends the full Excalidraw scene back to the server (overwriting). Excalidraw internally generates a bound text element for every shape that has `label.text`. If you clear and re-send elements, Excalidraw may re-inject its cached bound texts, causing duplicates. To clean up: (1) use `query_elements` / `GET /api/elements` to find elements of `type: "text"` with a `containerId`; (2) delete the unwanted ones with `delete_element`; (3) wait a few seconds for auto-sync to settle before exporting. The safest approach is to **never put labels on background zone rectangles** — use free-standing text elements instead.

---

## References

- `references/cheatsheet.md`: Complete MCP tool list (26 tools) + REST API endpoints + payload shapes.

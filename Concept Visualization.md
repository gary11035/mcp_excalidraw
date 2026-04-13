---
name: Concept Visualization
description: Create structural diagrams, architecture maps, and concept visualizations that make visual arguments. Use when the user wants to visualize workflows, system architecture, document structure, or concepts — including turning long-form technical documents into single-page self-explanatory diagrams.
---

# Concept Visualization Skill

> Turn long-form technical documents into single-page structural diagrams that are self-explanatory without the original text.

---

## 0. Language Rule (MANDATORY)

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

## 1. Core Philosophy

You are not "drawing a diagram." You are **re-encoding information architecture**. A linear document has one reading path; a structural diagram has simultaneous visual entry points. Your job is to make the reader grasp in 10 seconds what took 10 minutes to read.

**Three governing principles:**

1. **One diagram, one question.** Each diagram answers exactly one cognitive question: "What is it made of?" (architecture), "Why does it work?" (methodology), or "How is it different?" (comparison). Never mix these.
2. **Content determines form.** The type of information dictates the visual structure. Do not pick a chart type first and force content into it.
3. **Abstraction ladder.** Source documents live at implementation level (code, schemas, CLI commands). Diagrams must climb to concept level (knowledge model, data flow pattern, design tradeoffs). Strip away implementation details; preserve design intent.

**The Isomorphism Test:** If you removed all text, would the structure alone communicate the concept? If not, redesign.

**The Education Test:** Could someone learn something concrete from this diagram, or does it just label boxes? A good diagram teaches — it shows actual formats, real event names, concrete examples.

---

## 2. Pre-Work: Decompose the Source

Before drawing anything, perform this analysis **in order**:

### Step A — Identify the cognitive units

Read the entire source. Mark every section that answers one of these questions:

| Question                                       | Diagram type         | Example                                  |
| ---------------------------------------------- | -------------------- | ---------------------------------------- |
| What are the parts and how do they stack?      | Layered architecture | System components, dependency chains     |
| What happens when X is triggered?              | Flowchart / process  | Ingest pipeline, query execution         |
| What are the key ideas and how do they relate? | Concept map          | Design philosophy, methodology framework |
| How do two things compare on multiple axes?    | Comparison matrix    | Product A vs Product B                   |
| What are the categories and their members?     | Grouped cards        | Use cases, role responsibilities         |

### Step B — Decide how many diagrams

Each cognitive question becomes one diagram. A typical technical spec produces 2–4 diagrams:

- Diagram 1: **System architecture** (parts + layers)
- Diagram 2: **Conceptual framework** (the "why" behind the design)
- Diagram 3: **Comparison** (if the source positions itself against alternatives)
- Optional Diagram 4: **Key processes** (can be embedded in Diagram 1 as a sidebar)

### Step C — Extract, don't summarize

For each diagram, pull out:

- **Nouns** → become nodes (boxes)
- **Verbs / relationships** → become arrows
- **Categories** → become color groups
- **Hierarchies** → become spatial position (top = consumer, bottom = storage)
- **Core insight** → becomes a highlighted callout box at the bottom

### Step D — Assess depth required

Before designing, determine if this diagram needs to be:

- **Simple / Conceptual:** Abstract shapes, labels, relationships (mental models, philosophies)
- **Comprehensive / Technical:** Concrete examples, code snippets, real data (systems, architectures, tutorials)

If comprehensive: research first. Look up actual specs, formats, event names, APIs.

---

## 3. Visual Grammar (The Rules)

### 3.1 Shape vocabulary — keep it minimal

| Shape                                                                     | Meaning                                     | When to use                                       |
| ------------------------------------------------------------------------- | ------------------------------------------- | ------------------------------------------------- |
| **Rounded rectangle**                                                     | Entity / component / concept                | Default. Use for everything unless below applies. |
| **Ellipse**                                                               | Start trigger / end result / external actor | Entry points, outputs, cloud services             |
| **Diamond**                                                               | Decision / branch point                     | Only in flowcharts. "Does X exist?" Yes/No paths. |
| **Callout box** (rounded rect with thicker border or distinct background) | Core insight / summary                      | One per diagram, at the bottom. The "so what."    |

Do NOT introduce hexagons, stars, icons, or illustrations. Cognitive load increases with shape variety.

**Exception:** Small colored dots/circles (●) may be used as bullet markers next to list items within a concept group, not as standalone nodes.

**Container vs. Free-Floating Text:** Not every piece of text needs a shape around it. Default to free-floating text for labels, descriptions, and section titles. Add containers only when the element is a focal component, needs arrow connections, or represents a distinct "thing" in the system. Aim for **< 30% of text elements inside containers**.

### 3.2 Color system — semantic, not decorative

**Rule: Each color = one semantic category, consistent across all diagrams in a set.**

Assign colors at the start and never reassign. Use the **Nash-style warm palette**:

```
Layer / category          Fill        Stroke / dark text
──────────────────────────────────────────────────────────
消費層 Consumer/external  #b2ebf2     #00838f   (teal)
介面層 Interface/API      #d1c4e9     #512da8   (purple)
核心庫 Core logic         #c8e6c9     #2e7d32   (mint green)
存儲層 Storage/data       #dcedc8     #558b2f   (light olive)
技能層 Skills             #ffe0b2     #e65100   (peach/orange)
流程步驟 Process steps     #f8bbd0     #880e4f   (coral pink)
結果/高亮 Result           #b2dfdb     #00695c   (mint teal)
決策 Decision             #fff9c4     #f57f17   (light gold)
比較側A Comparison A      #d1c4e9     #512da8   (purple)
比較側B Comparison B      #c8e6c9     #2e7d32   (mint green)
AI/LLM (special)          #e8d5fe     #6d28d9   (lavender)
核心洞察 Core insight      #fff3cd     #856404   (warm yellow)
```

**Accent / trigger rule:** The single most important entry point (external user, start trigger) MAY use a **high-saturation ellipse** (e.g., `#FFB300` gold fill, `#E65100` stroke) to create a deliberate visual anchor. Limit to **one** per diagram.

**Saturation rule:** All other fills stay pastel (HSL saturation 30–45%). The accent ellipse is the only exception.

**Text color follows fill:** Each category's text uses the darker stroke color of that row. Never black text (`#000000`) on colored fills.

**Stroke rule:** Always pair a darker stroke with a lighter fill. Connector lines: `#999999` (thin, neutral, roughness 1).

### 3.3 Typography hierarchy

```
Level 1 — Diagram title      fontSize: 28, centered, color: #1e40af (or matching hue)
Level 2 — Subtitle           fontSize: 16, gray (#888888), one line below title
Level 3 — Section labels      fontSize: 14, colored text matching section hue, left-aligned, no container
Level 4 — Node titles         fontSize: 14–16, inside boxes (first line = title)
Level 5 — Node descriptions   fontSize: 12–13, inside boxes below title
Level 6 — Annotations         fontSize: 11, gray (#888888), outside boxes
Core insight callout          fontSize: 15–16, bold key sentence + normal explanation lines
```

**Font (CRITICAL):** Use `fontFamily: 1` (Virgil — Excalidraw 手寫字體) for ALL text elements. This is the signature visual style. It gives diagrams a personal, sketch-quality feel rather than a printed document look.

**Font rule:** Single font family (fontFamily: 1) throughout. Title uses larger fontSize only — no separate display font needed because Virgil already has personality.

### 3.4 Layout patterns

Choose the layout that matches the information type:

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
- Horizontal spacing is even; nodes in a row are the same height.

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
...
         ┌─ When A... ─┐     ┌─ When B... ─┐
         │ criteria     │     │ criteria     │
         └──────────────┘     └──────────────┘
┌──────────── Meta-verdict (full width, warm yellow) ─────────────┐
```

- **Left column** = dimension labels (free-floating colored text, no container).
- **Center two columns** = description cells, each colored by side (Side A = purple, Side B = green).
- **Right edge Verdict tags** = small rounded rectangles (~80×28px), color encodes outcome:
  - 平局 / 各异 → `#FFF3CC` (gold)
  - Side A wins → `#d1c4e9` (purple)
  - Side B wins → `#c8e6c9` (green)
    Each tag has 1–2 word text (e.g., 「GBrain」「Wiki」「平局」).
- **Bottom** = 「選 A 當...」+「選 B 當...」side-by-side recommendation boxes.
- **Final row = meta-insight callout** — full width, warm yellow background (`#fff3cd`), larger font (fontSize: 15), bold key sentence on line 1.

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
- Diamond for decisions with labeled branches (Yes/No or condition text).
- Converge paths back to a single outcome node.
- Use arrows labeled with short verbs or outcomes on branch paths.
- Terminal nodes (outcomes, outputs) use ellipse shape with accent color.

#### Pattern E — Sidebar Composition (structure + behavior)

When a single diagram needs to show both structure and behavior:

- Left 60% = static architecture (Pattern A)
- Right 40% = dynamic processes (Pattern D or concept map)

Separate the two halves with whitespace, not a line. They share the same color system.

### 3.5 Multi-Zoom Architecture

Comprehensive diagrams operate at multiple zoom levels simultaneously:

**Level 1 — Summary Flow:** A simplified overview (e.g., `Input → Processing → Output`) placed at the top or bottom.

**Level 2 — Section Boundaries:** Labeled regions that group related components. These create visual "rooms."

**Level 3 — Detail Inside Sections:** Concrete examples, file names, API endpoints, real data formats within each section.

For comprehensive / technical diagrams, aim to include all three levels.

### 3.6 Connector lines

- **Style:** Thin (1–1.5px), `strokeColor: "#AAAAAA"`, with arrowheads.
- **Routing:** Straight or single-bend orthogonal. No curves, no bezier. No crossing lines — rearrange nodes to avoid crossings.
- **Labels on arrows:** Only when the relationship is non-obvious. Keep labels to 1–3 words.
- **Direction convention:** Top→Down for dependency, Left→Right for process flow.
- **Semantic color:** Important arrows (core data flow, main process) may use the source element's stroke color for emphasis.

### 3.7 Text inside nodes — THE CRITICAL STEP

**A box without text is a colored rectangle. A box with text is knowledge.** This is the single most common failure mode. Every node MUST contain text. No exceptions.

#### 3.7.1 Node anatomy

Every node has exactly two text layers:

```
┌──────────────────────────────────────┐
│  Title (bold, larger font)           │
│  Description line 1                  │
│  Description line 2                  │
│  Description line 3 (max)            │
└──────────────────────────────────────┘
```

**Title** = WHAT it is. The name. 1–5 words.
**Description** = WHY it matters or WHAT it does. 1–3 lines of sentence fragments.

Both are mandatory. A node with only a title is incomplete. A node with only a description and no title is unreadable.

#### 3.7.2 How to write the title

The title is the **noun phrase** that names this node:

- Use the source document's own terminology. Do not rename things.
- If the source calls it "MCP Server (stdio)", the title is `MCP Server (stdio)`.
- If the source uses an acronym, keep it: `FTS5 关键词` not `Full-Text Search Version 5 Keyword Matching`.
- Technical identifiers stay as-is: `db.ts`, `brain.db`, `page_fts`.
- For concept nodes (not code), use a short noun phrase: `编译真相` (Compiled Truth), `三层搜索` (Three-Layer Search).

#### 3.7.3 How to write the description

The description must answer: **"If I only read this box, do I know enough?"**

**Five writing patterns for descriptions (pick the one that fits):**

**Pattern 1 — Role statement** (for components): State what the component does. Use verb-first fragments.

```
┌──────────────────────────────────┐
│  embeddings.ts                   │
│  Generate vectors from text      │
│  Cosine similarity search        │
│  OpenAI text-embedding-3-small   │
└──────────────────────────────────┘
```

**Pattern 2 — Bullet-style properties** (for concepts / models): List 2–4 key properties. Use sentence fragments and slashes for alternatives.

```
┌──────────────────────────────────┐
│  线上: 编译真相                     │
│  Always current                  │
│  Rewrite on new info             │
│  State section overwritten       │
│  Summary / Status / Assessment   │
└──────────────────────────────────┘
```

**Pattern 3 — Input → Output** (for process steps): State what goes in and what comes out. Use arrow notation within text.

```
┌──────────────────────────────────┐
│  Ingest 摄入                      │
│  Source doc → LLM read/discuss   │
│  → Write summary / update index  │
│  One source → 10-15 Wiki pages   │
└──────────────────────────────────┘
```

**Pattern 4 — Contrast pair** (for comparison cells): Key fact on line 1, implication on line 2.

```
┌──────────────────────────────────┐
│  Markdown 文件目录                 │
│  Obsidian native, Git-friendly   │
│  Human-readable, most open       │
└──────────────────────────────────┘
```

**Pattern 5 — Enumeration** (for leaf nodes listing members): List members using slashes or commas.

```
┌──────────────────────────────────┐
│  Wiki 层  LLM 生成的 Markdown     │
│  Overview / Entity / Concept     │
│  Comparison pages                │
│  LLM fully owns; you only read  │
└──────────────────────────────────┘
```

#### 3.7.4 Text density rules

| Node type              |  Title required?   |                  Description required?                  |      Description lines       |
| ---------------------- | :----------------: | :-----------------------------------------------------: | :--------------------------: |
| Architecture component |        YES         |                           YES                           |          1–2 lines           |
| Concept / model        |        YES         |                           YES                           |          2–4 lines           |
| Process step           |        YES         |                           YES                           |          1–2 lines           |
| Comparison cell        |        YES         |                           YES                           | 2 lines (fact + implication) |
| Leaf / terminal node   |        YES         | Optional (if siblings have descriptions, this must too) |           0–1 line           |
| Decision diamond       | YES (the question) |          NO (branches carry the text instead)           |              0               |
| Core insight callout   |  NO title needed   |              YES — the insight IS the text              |        1–3 sentences         |

**Balance rule:** If any node in a group has a description, ALL nodes in that group must have descriptions. Mixed title-only + described nodes within the same visual cluster looks broken.

#### 3.7.5 Text formatting inside nodes

- **No markdown syntax.** No `**bold**`, no `- bullets`, no `1. numbered`. Visual hierarchy comes from font size and weight, not markup characters.
- **Slashes for alternatives:** `搜索/综合/引用` or `search / synthesize / cite`
- **Commas for lists:** `pages, page_fts, embeddings, links`
- **Arrow notation for flow:** `source → LLM → wiki pages`
- **Parenthetical clarifiers:** `MCP Server (stdio)`, `brain.db (SQLite)`
- **Line breaks between distinct ideas.** Each line is one thought. Do not wrap a single thought across two lines.
- In Excalidraw JSON: `"text"` and `"originalText"` must contain only readable words (no escape sequences rendered as visible text).

#### 3.7.6 Section labels (text outside nodes)

Every layer or group needs a **section label** — colored text placed above-left of the group, matching the group's hue. This label names the entire cluster.

```
消费层                          ← section label (blue text, no box)
┌──────────┐  ┌──────────┐
│ Claude   │  │Wintermute│    ← nodes (blue fill)
│ Code     │  │          │
└──────────┘  └──────────┘

接口层                          ← section label (purple text)
┌────────────────┐
│ MCP Server     │              ← node (purple fill)
│ stdio transport│
└────────────────┘
```

Section labels are NOT inside boxes. They float as standalone colored text. They serve as the reader's navigation landmark.

#### 3.7.7 Title and subtitle of the entire diagram

```
       GBrain 整体架构                    ← Level 1: large, color #1e40af
SQLite + FTS5 + 向量嵌入 · 薄 CLI · MCP    ← Level 2: smaller, gray #64748b
```

- **Title:** Name + type. `[Subject] [Diagram Type]`. E.g., "GBrain 整体架构", "LLM Wiki 方法论".
- **Subtitle:** A one-line technical summary using middle-dot (·) as separator.
- **Together they answer:** "What am I looking at, and what world does it belong to?"

#### 3.7.8 The "no empty box" test

After placing all nodes, run this test:

1. Point to each box in the diagram.
2. Read only the text inside that box.
3. Ask: "Do I know what this is and why it exists?"
4. If the answer is no → add description lines.
5. If you cannot write a description → this node is at the wrong abstraction level, or it should not be a separate node.

**A diagram full of colored rectangles without text is a wireframe, not a concept visualization.**

### 3.8 Spatial semantics

Position encodes meaning:

| Position      | Meaning                                  |
| ------------- | ---------------------------------------- |
| Top           | Consumers, callers, external-facing      |
| Bottom        | Storage, foundation, infrastructure      |
| Left          | Primary / main path                      |
| Right         | Secondary / supplementary info / sidebar |
| Center        | Core, the thing everything connects to   |
| Bottom-right  | Credits, authorship                      |
| Bottom-center | Core insight / meta-conclusion callout   |

**Whitespace = Importance:** The most important element has the most empty space around it. Dense clusters indicate a logical unit. Space between clusters indicates a boundary.

---

## 4. The Abstraction Process

This is the most important skill. Source documents contain implementation details. Your diagram must show design concepts.

### Translation rules:

| Source (implementation)                              | Diagram (concept)                                                                           |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| SQL schema with 9 tables                             | "Storage layer: brain.db" with table names as small nodes                                   |
| 500 lines of TypeScript in 5 files                   | "Core library: gbrain-core" with file names as small nodes                                  |
| 15-step CLI command reference                        | "Interface layer" with two nodes: "MCP Server" + "CLI"                                      |
| Detailed ranking formula (FTS5 × 0.4 + vector × 0.6) | Flowchart: "FTS5 Keywords (weight 0.4)" + "Vector Semantic (cosine × 0.6)" → merge → result |
| 7-paragraph design rationale                         | One callout box with the core sentence                                                      |
| Code example with 30 lines                           | Omit entirely. Not for this medium.                                                         |

### What to cut:

- Code snippets — always omit
- Configuration examples — always omit
- Step-by-step instructions — compress to 3–5 flow nodes maximum
- Error handling / edge cases — omit
- Version numbers / dependencies — omit unless they are the point

### What to promote:

- Design tradeoffs (Why X over Y?) → becomes a comparison row or callout
- Naming conventions → becomes a legend or inline label
- The "core insight" paragraph (every good spec has one) → becomes the bottom callout box

---

## 5. Excalidraw JSON Specifics

When generating Excalidraw `.excalidraw` files, follow these technical rules:

### JSON structure

```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://excalidraw.com",
  "elements": [...],
  "appState": {
    "viewBackgroundColor": "#ffffff",
    "gridSize": 20
  },
  "files": {}
}
```

### ⚠️ JSON Strict Rules (CRITICAL)

**Excalidraw files are pure JSON. JSON does NOT support any form of comments.**

- ❌ `// this is a comment` — INVALID. Causes `Error: Unable to load initial data`.
- ❌ `/* block comment */` — INVALID. Same error.
- ✅ Only write valid JSON key-value pairs. No annotations, no inline notes.

If you need to annotate your reasoning, do it in the chat response — NEVER inside the JSON file.

### Visual Style Settings (Nash-style)

- `fontFamily: 1` — **Virgil / Excalifont (手寫字體)**. Default for ALL text elements.
- `roughness: 1` — Slight hand-drawn edge on shapes and arrows. Give a personal sketch feel.
- `strokeWidth: 1` for section outlines/dividers, `2` for primary component shapes.
- `lineHeight: 1.25` on all text elements.
- `opacity: 100` — Always.

**Do NOT use `fontFamily: 3` (monospace) or `roughness: 0` (pixel-perfect). Those produce a different aesthetic.**

### 🎨 Preferred Font: 霞鶩文楷 (LXGW WenKai)

The USER prefers **霞鶩文楷 (LXGW WenKai)** — a Chinese brushstroke-inspired open-source font — for all diagrams.

**Why it cannot be set directly in JSON:**
Excalidraw's `fontFamily` is a fixed integer (1=Excalifont, 2=Nunito, 3=Comic Shanns). There is no built-in integer for LXGW WenKai. Setting an arbitrary number will have no effect.

**How to apply it in practice:**

1. **When using excalidraw.com or VS Code plugin** — The AI generates JSON with `fontFamily: 1` as always. After opening the file, the user can install a browser extension (e.g., Tampermonkey) with this CSS snippet to override Virgil with LXGW WenKai:

   ```css
   @import url("https://cdn.jsdelivr.net/npm/lxgw-wenkai-webfont@1.7.0/style.css");
   .excalidraw text,
   canvas {
     font-family: "LXGW WenKai", Virgil, sans-serif !important;
   }
   ```

2. **When using excalidraw-cn (王俊峰修改版)** — That fork already bundles LXGW WenKai and similar Chinese hand-drawn fonts natively. Just open the `.excalidraw` file in it; the font will render automatically.

3. **When using Obsidian Excalidraw plugin** — Add the CSS snippet above in Settings → Appearance → CSS Snippets, and ensure LXGW WenKai is installed locally or loaded from CDN.

**AI instruction**: Always generate JSON with `fontFamily: 1`. Mention in the response that the user should open the file in excalidraw-cn or use the Tampermonkey snippet to get 霞鶩文楷 rendering.

### ⚠️ Bound Text Rule (CRITICAL — shapes are ALWAYS empty without this)

In Excalidraw JSON, the `text` field on `rectangle` / `ellipse` / `diamond` shapes is **never rendered**. Text inside shapes requires a **separate bound text element** linked by `containerId`.

Every shape with visible text needs **two JSON objects**:

```json
{
  "type": "rectangle",
  "id": "rect_main",
  "x": 100, "y": 100, "width": 240, "height": 80,
  "fillStyle": "solid", "backgroundColor": "#E8DEFF",
  "strokeColor": "#5a2d91", "strokeWidth": 2,
  "roughness": 0, "opacity": 100, "angle": 0,
  "isDeleted": false,
  "boundElements": [{"id": "txt_main", "type": "text"}]
},
{
  "type": "text",
  "id": "txt_main",
  "containerId": "rect_main",
  "x": 100, "y": 100, "width": 240, "height": 80,
  "text": "頁面入口\nChatBotV1/V2.html",
  "originalText": "頁面入口\nChatBotV1/V2.html",
  "fontSize": 13, "fontFamily": 3,
  "textAlign": "center", "verticalAlign": "middle",
  "strokeColor": "#5a2d91", "backgroundColor": "transparent",
  "fillStyle": "solid", "strokeWidth": 1,
  "roughness": 0, "opacity": 100, "angle": 0,
  "isDeleted": false, "lineHeight": 1.25
}
```

**Rules:**

- The shape element: add `"boundElements": [{"id": "txt_XXX", "type": "text"}]`. Remove or leave empty the `text` field.
- The text element: set `"containerId": "shape_id"`. Its `x`, `y`, `width`, `height` match the parent shape.
- **Do NOT put text directly in the shape element** — it will not appear.
- Standalone free-floating text (section labels, diagram title) uses `type: "text"` with **no `containerId`**.

### Element settings

- `roughness: 0` — Clean, crisp edges for professional diagrams.
- `opacity: 100` — Always. Never use transparency.
- `strokeWidth: 1` for thin lines/dividers, `2` for primary shapes, `3` for key accent connections.
- `fontFamily: 3` for all text elements.
- `lineHeight: 1.25` on all text elements.
- `textAlign: "center"` for node labels, `"left"` for descriptions and section labels.
- `verticalAlign: "middle"` for all text.
- **Dynamic Font Scaling**: Text must dynamically fill its container. You must adjust `fontSize` (e.g. 11, 12, 13, 14...) according to the width/height of the bounded rectangle or ellipse. Text should look "full" inside the shape, with appropriate margins, instead of leaving huge empty spaces.

### Large diagram strategy

For comprehensive diagrams, **build JSON one section at a time**. Never attempt to generate the entire file in one pass.

1. **Create the base file** with JSON wrapper + first section of elements.
2. **Add one section per edit.** Think carefully about layout, spacing, and cross-section connections.
3. **Use descriptive string IDs** (e.g., `"trigger_rect"`, `"arrow_fan_left"`) — not numeric.
4. **Update cross-section bindings** as you go.
5. **Review the whole** after all sections: verify arrows, spacing, ID references.

---

## 6. Render & Validate (MANDATORY)

After generating or editing any Excalidraw JSON, you MUST visually inspect the output before delivery.

### The validation loop

1. **Render** — Generate or preview the diagram.
2. **Audit vision** — Does the structure match your conceptual design? Is each section using the right layout pattern?
3. **Check defects:**
   - Text clipped or overflowing its container
   - Elements overlapping unintentionally
   - Arrows connecting to wrong targets
   - Labels not anchored to what they describe
   - Uneven spacing or lopsided composition
   - Text too small to read
4. **Fix** — Edit coordinates, widen containers, route arrows, reposition labels.
5. **Re-render** — Repeat until the diagram passes both vision and defect checks.

### Stop when:

- Rendered diagram matches conceptual design
- No text is clipped, overlapping, or unreadable
- Arrows route cleanly to correct elements
- Spacing is consistent and composition is balanced
- You'd be comfortable showing it without caveats

---

## 7. Composition Checklist

Before finalizing a diagram, verify:

### Content & Structure

- [ ] **One question per diagram.** Can you state the question it answers in one sentence?
- [ ] **No empty boxes.** Every single node has both a title AND a description. Run the "point and read" test (§3.7.8).
- [ ] **Text density is balanced.** No node has more than 4 description lines. No title-only nodes if siblings have descriptions.
- [ ] **Core insight exists.** There is one callout box at the bottom with the "so what" takeaway.
- [ ] **Self-contained.** Someone who has NOT read the source document can understand the diagram.

### Color & Style

- [ ] **Color is semantic.** Can someone explain what each color means without a legend?
- [ ] **Nash palette used.** Teal / mint green / peach / coral pink / lavender — warm palette, NOT blue-purple.
- [ ] **Saturation is pastel.** No over-saturated fills on large areas (except the ONE accent ellipse trigger).
- [ ] **Text color follows fill.** Use the darker stroke color of each palette row as text color.
- [ ] **No decoration.** No icons, clip art, gradients, shadows, or 3D effects.
- [ ] **roughness: 1**, **opacity: 100**, **fontFamily: 1** on all elements.

### Layout & Typography

- [ ] **Section labels exist.** Every cluster has a colored text label above-left. No labels inside boxes.
- [ ] **Diagram title + subtitle exist** at the top.
- [ ] **Hierarchy is visible.** Eye flows top→down or left→right without numbered steps.
- [ ] **Whitespace is intentional.** Dense clusters = logical unit. Space = boundary.
- [ ] **No orphan nodes.** Every node connects via arrow or spatial grouping.
- [ ] **Container ratio < 30%.** Most text is free-floating, not boxed.

### Technical (Excalidraw)

- [ ] **No comments in JSON.** Zero `//` or `/* */` anywhere in the file. Comments cause `Unable to load initial data` crash.
- [ ] **Bound text used for all shapes.** Every rectangle/ellipse/diamond with visible text has a paired `type: "text"` element with `containerId`. No text is placed directly in shape elements.
- [ ] **fontFamily: 3** and **lineHeight: 1.25** on all text elements.
- [ ] **Text fields** contain only readable words (no markdown syntax, no escape chars visible).
- [ ] **Arrows land correctly** on intended elements without crossing others.
- [ ] **IDs are descriptive** strings, not random hashes.
- [ ] **Attribution** in bottom-right, small gray text.

---

## 8. Multi-Diagram Set Rules

When producing 2+ diagrams from the same source:

1. **Shared color assignments.** If "core library" is green in Diagram 1, it stays green in Diagram 2.
2. **Escalating abstraction.** Diagram 1 = architecture (most concrete). Diagram 2 = methodology (more abstract). Diagram 3 = comparison (most evaluative).
3. **Consistent title format.** `[Subject] [Diagram Type]` — e.g. "GBrain 整体架构", "LLM Wiki 方法论", "LLM Wiki vs GBrain 对比".
4. **Consistent subtitle.** One-line tech stack summary using middle-dot (·) separator.
5. **Same canvas proportions.** All diagrams use roughly the same width:height ratio (16:9 landscape preferred).

---

## 9. Diagram Types — Decision Tree

```
What does the source content describe?
│
├─ A system with parts that depend on each other
│  → Layered Architecture (Pattern A)
│  → Question: "What is it made of?"
│
├─ A philosophy or framework with parallel concepts
│  → Concept Grid (Pattern B)
│  → Question: "Why does it work this way?"
│
├─ Two or more alternatives evaluated on dimensions
│  → Comparison Matrix (Pattern C)
│  → Question: "How is it different from X?"
│
├─ A sequence of steps with decisions
│  → Flowchart (Pattern D)
│  → Question: "What happens when X is triggered?"
│
└─ A mix of structure + process
   → Sidebar Composition (Pattern A left + Pattern D right)
   → Question: "What is it and how does it work?"
```

---

## 10. Common Mistakes

| Mistake                                   | Why it fails                                                                                    | Fix                                                                                     |
| ----------------------------------------- | ----------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| **Empty boxes / title-only nodes**        | Colored rectangles without text are meaningless shapes. #1 failure mode.                        | Every node gets a title + 1–3 description lines. Run the "point and read" test.         |
| Missing section labels                    | Reader can't tell which group a node belongs to. Clusters blur together.                        | Add colored text label (no box) above-left of every cluster.                            |
| Missing diagram title/subtitle            | Reader has no entry point.                                                                      | Always start with large title + one-line gray subtitle at the top.                      |
| Using 6+ colors                           | Reader can't decode the color system.                                                           | Max 5 semantic colors per diagram.                                                      |
| Putting code in nodes                     | Wrong abstraction level.                                                                        | Name the module; describe its role in 5 words.                                          |
| Arrows everywhere                         | Spaghetti. Reader gives up.                                                                     | Fewer connections. Use spatial grouping for "belongs to" instead of arrows.             |
| Mixing structure and comparison           | Two cognitive modes fighting.                                                                   | Split into two diagrams.                                                                |
| Decorative icons                          | Visual noise, no information.                                                                   | Remove. Shape + color + text is enough.                                                 |
| Everything the same size                  | No hierarchy signal.                                                                            | Key nodes larger; leaf nodes smaller.                                                   |
| **Puny text in huge boxes**               | Wastes space, looks amateurish. Text is not full or fitted.                                     | Dynamically adjust `fontSize` to scale up and fully occupy the bounded container size.  |
| Boxed section labels                      | Labels lose navigation function when trapped in containers.                                     | Section labels are always free-floating colored text.                                   |
| Legend box                                | The diagram has failed if it needs a legend.                                                    | Make colors self-evident through consistent usage and section headers.                  |
| Large diagram in one JSON pass            | Truncated / broken output.                                                                      | Build section by section.                                                               |
| **`//` comments inside JSON**             | JSON spec forbids comments. Causes `Error: Unable to load initial data` — file silently broken. | Write comments in chat response only. The `.excalidraw` file must be pure valid JSON.   |
| **Text placed directly in shape element** | `rectangle.text` is never rendered by Excalidraw. Shapes appear empty. #2 failure mode.         | Always create a paired `type: "text"` element with `containerId` pointing to the shape. |

---

## 11. Workflow Summary

```
0.  ASSESS — simple/conceptual or comprehensive/technical?
    If technical: RESEARCH actual specs, event names, API formats first.

1.  READ the entire source document
2.  MARK cognitive units (what / why / how-different / process)
3.  ASSIGN one diagram per cognitive question
4.  EXTRACT nouns (→ nodes), verbs (→ arrows), categories (→ colors)
5.  CHOOSE layout pattern (A/B/C/D/E) per diagram
6.  CLIMB the abstraction ladder (implementation → concept)
7.  PLACE nodes using spatial semantics (top=consumer, bottom=storage)
8.  LABEL section headers — colored free-floating text above each node cluster
9.  WRITE titles into every node — the noun phrase naming this thing
10. WRITE descriptions into every node — 1-3 lines answering "what does it do / why
    does it matter." Pick pattern: role statement / properties / input→output /
    contrast / enumeration.
11. CONNECT with thin gray arrows (no crossings, no spaghetti)
12. INSERT core-insight callout at the bottom
13. ADD diagram title (large, #1e40af) + subtitle (small, gray #64748b)
14. BUILD JSON section by section (never all at once for large diagrams)
15. RENDER & VALIDATE — inspect visually, fix defects, re-render until clean
16. RUN composition checklist (§7) — especially "no empty boxes"
17. VERIFY: can someone who hasn't read the source understand this?
```

**Steps 9 and 10 are where most diagrams fail.** A common trap is to finalize layout and colors first, intending to "fill in text later," then running out of patience. **The text IS the diagram. Layout and color are scaffolding.**

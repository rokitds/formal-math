# Rules for working in `learning/`

This folder is a Lean course: exercise sheets (`lean/`), ManimCE animations (`scenes/`) and a
website (`site/`, Astro + MDX). These rules keep every lesson consistent no matter who, or which
agent, writes it. `npm run build` in `site/` runs `scripts/check-lessons.mjs` first and fails on
the mechanical ones.

## Lean sheets (`lean/LeanLearning/WeekNN/`)

- One file per sheet, named `ENN_Topic.lean`, imported from `lean/LeanLearning.lean`.
- The module docstring starts with `# Week N, sheet M: topic` (the site shows this as the title),
  explains the new tactics, and names the reading.
- Worked examples are anonymous `example`s with complete proofs.
- Exercises are `theorem exN_M ... := by` followed by `  sorry` and then a blank line. The site
  extracts an exercise from its name down to the next blank line, with the docstring above it.
- Never commit solutions on the learner's branch. Check that each exercise is solvable by
  proving it in a scratch file before committing the sheet.
- Same toolchain and Mathlib commit as `../vp-vnp`, so one Mathlib cache serves both.

## Lessons (`site/src/pages/lessons/week-NN.mdx`)

- Frontmatter: `layout`, `title`, `week`, `time`, `summary`.
- Lean code appears only through `<LeanSheet file=... />` and `<LeanExercise file=... name=... />`.
  Never paste Lean into a code block: pasted code drifts from what `lake build` checks.
- Animations appear only through `<Scene name=... source=... caption=... />`. Never a raw `<video>`.
- Tips and warnings use `<Callout>` (`kind="note"` or `kind="caution"`). No raw blockquotes or asides.
- No inline styles or `<style>` in lessons. Styling lives in components and layouts. If a lesson
  needs a new kind of element, add a component and a rule here.
- Inline code (single backticks) for tactic and definition names is fine.
- Write in plain, friendly sentences for someone who knows school proofs and some complexity theory.

## Scenes (`scenes/`)

- ManimCE (Manim Community Edition), not 3b1b's manimgl.
- Plain `Text` and `Code` only, no `MathTex`, so rendering needs no LaTeX install.
- Any goal state shown in a scene must be copied from Lean's Infoview, not written from memory.
- Render with `manim -qm file.py SceneName` and copy the 720p video to
  `site/public/scenes/SceneName.mp4`.

## Accuracy about VP ≠ VNP

The proof in `../vp-vnp` was written by an AI model and has not been checked by a human
mathematician. Never present it as an established result. Say "claimed" or "formalized", and say
what Lean does and does not guarantee.

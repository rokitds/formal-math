# Course context

Background for anyone, human or AI, picking up this course. `CLAUDE.md` imports this file, so
Claude Code started in `learning/` reads it automatically.

## Goal

Learn Lean 4 well enough to reason about the VP ≠ VNP formalization in `../vp-vnp`, in this order:

1. Understand its Lean statement (`../vp-vnp/Statement.lean`, about 100 lines, Mathlib only).
2. Check that the statement says what the paper (`../vp-vnp/paper.pdf`, Appendix Q) claims.
3. Follow parts of the proof.
4. Write original proofs in the area.

A second goal is to turn the course into public material: the website in `site/`, and later
videos built from the ManimCE scenes in `scenes/`.

## The learner

- Proofs: secondary-school level. Complexity theory (P vs NP) at university, needs a refresher.
  New to Lean.
- Time: a few hours a week.
- Editor: Doom Emacs with lean4-mode (see `SETUP.md`), not VS Code.
- Likes: set exercises that get checked, plus guided reading (*Mathematics in Lean*).
- Web: experienced with React, dislikes hooks, values reusable components that encode
  presentation rules.

## The plan

| Step | Content | Scene | Status |
|---|---|---|---|
| 1 | Setup and Lean basics: equations, logic, sets | Goal state | Week 1 ready |
| 2 | Complexity refresher: circuits, P vs NP, VP vs VNP; `MvPolynomial` in Mathlib | Arithmetic circuit | Not started |
| 3 | Read `Statement.lean` line by line against the paper | Definitions building to the theorem | Not started |
| 4 | Trace a lemma chain in the proof; own proofs; outline the video series | Map of the proof | Not started |

## Decisions already made

- ManimCE, not 3b1b's manimgl: better docs, more stable. Scenes use no LaTeX.
- Astro + MDX for the site. Lessons only use components (see `CLAUDE.md`), enforced by a
  prebuild check.
- No Verso: Lean code stays in real `.lean` files that `lake build` checks, and the site reads them.
- `lean/` uses the same Lean and Mathlib versions as `../vp-vnp`, so one Mathlib cache serves both.
- Solutions are never committed. The learner's answers are the solutions.
- The site is published to GitHub Pages from `main` by `.github/workflows/learning.yml`.

## How to help as a tutor

- The learner is here to learn. When they're stuck on an exercise, ask what the goal state
  shows, then give the smallest useful hint (a tactic name, or which hypothesis to look at).
  Never paste a full solution unless they ask for one outright.
- To check a solved sheet: run `lake build` in `lean/`. It must succeed with no `sorry`
  warnings for that sheet. Then comment on style: shorter proofs, better tactic choices, and
  how a paper proof would say the same thing.
- Explain new Lean ideas in terms of the goal state, and link each idea back to where it shows
  up in `../vp-vnp/Statement.lean` when it does.
- The VP ≠ VNP proof was written by an AI model and has not been checked by a human
  mathematician. Say "claimed" or "formalized", never "proved" in the everyday sense.

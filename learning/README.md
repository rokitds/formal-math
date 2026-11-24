# Learning Lean, toward VP ≠ VNP

A course in progress: from zero Lean to reading the Lean formalization of VP ≠ VNP in
[`../vp-vnp`](../vp-vnp). Each week has exercise sheets, guided reading, and a ManimCE animation.
The lessons are published as a website, so the material can be reused for others, and later for videos.

## Layout

| Folder | What's in it |
|---|---|
| [`lean/`](lean/) | A Lake project with the exercise sheets, one folder per week. Same Lean and Mathlib versions as `vp-vnp`. |
| [`scenes/`](scenes/) | ManimCE animations, one Python file per scene. |
| [`site/`](site/) | The course website (Astro + MDX). Lessons pull exercises straight from `lean/` and videos from `scenes/`. |
| [`SETUP.md`](SETUP.md) | How to install everything on your laptop. |
| [`COURSE.md`](COURSE.md) | The goal, the learner, the plan and past decisions. Context for a tutor, human or AI. |
| [`CLAUDE.md`](CLAUDE.md) | Rules for writing sheets, lessons and scenes, for people and AI agents alike. |

## The plan

1. **Setup and Lean basics** (about 3 weeks). Equations, logic and sets. Scene: the goal state.
2. **Complexity refresher and polynomials** (about 3 weeks). Circuits, P vs NP, VP vs VNP, and
   `MvPolynomial` in Mathlib. Scene: an arithmetic circuit computing a polynomial.
3. **Read and check the real statement** (about 2 to 3 weeks). Line by line through
   `vp-vnp/Statement.lean`, compared with the paper. Scene: the definitions building up to the theorem.
4. **Follow the proof, write your own** (open-ended). Trace a lemma chain, reprove pieces, and
   outline the video series. Scene: a map of the proof.

## How a week works

1. Read the lesson page and the chapters it points to.
2. Fill in the `sorry`s in that week's sheets, in `lean/LeanLearning/WeekNN/`.
3. When your editor shows no errors and no `sorry` warnings for a sheet, commit and push.
4. Feedback comes on the pull request.

Status: week 1 is ready.

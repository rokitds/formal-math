import Mathlib.Data.Set.Basic

/-!
# Week 1, sheet 3: sets

In Mathlib, a `Set α` is a predicate on `α`: `x ∈ s` is just a proposition. So set proofs are
logic proofs in disguise. `s ⊆ t` means `∀ x, x ∈ s → x ∈ t`, which is why proofs of `⊆` start
with `intro x hx`. To prove two sets are equal, use `ext x` and prove `x ∈ s ↔ x ∈ t`.

Why sets now: the headline claim of the VP ≠ VNP project is literally a set statement,
`VP F ⊂ VNP F` (strict subset), in `vp-vnp/Statement.lean`. Exercise 3.6 is a toy version.

Reading for this sheet: *Mathematics in Lean*, chapter 4.1 ("Sets").
-/

namespace LeanLearning.Week01

open Set

variable {α : Type*} (s t u : Set α)

/-! ## Worked examples -/

example : s ∩ t ⊆ s := by
  intro x hx
  exact hx.1

example : s ⊆ s ∪ t ∪ u := by
  intro x hx
  left
  left
  exact hx

example : s ∩ s = s := by
  ext x
  constructor
  · intro hx
    exact hx.1
  · intro hx
    exact ⟨hx, hx⟩

/-! ## Exercises -/

theorem ex3_1 : s ⊆ t ∪ s := by
  sorry

theorem ex3_2 (h : s ⊆ t) (h' : t ⊆ u) : s ⊆ u := by
  sorry

theorem ex3_3 : s ∩ t = t ∩ s := by
  sorry

theorem ex3_4 (h : s ⊆ t) : s ∩ u ⊆ t ∩ u := by
  sorry

theorem ex3_5 : s ∩ (t ∪ u) ⊆ (s ∩ t) ∪ (s ∩ u) := by
  sorry

/-- A strict subset: `s ⊂ t` means `s ⊆ t ∧ ¬ t ⊆ s`. To prove `VP ⊂ VNP` you need
both halves: everything in VP is in VNP (the easy half), and something in VNP is not in VP
(the hard half, which is the whole research result). Here, `x` plays the role of the permanent.
Hint: `rw [Set.ssubset_def]` turns the goal into the `∧` form. -/
theorem ex3_6 (h : s ⊆ t) (x : α) (hxt : x ∈ t) (hxs : x ∉ s) : s ⊂ t := by
  sorry

end LeanLearning.Week01

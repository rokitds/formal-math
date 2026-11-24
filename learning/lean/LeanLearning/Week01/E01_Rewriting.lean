import Mathlib.Tactic.Ring

/-!
# Week 1, sheet 1: equalities, `rfl`, `rw` and `ring`

Work in VS Code with the Lean 4 extension. Put the cursor after `by` and watch the
**Lean Infoview** panel: it shows the *goal state*, meaning what you still have to prove (after `⊢`)
and the facts you have (above it). Every tactic changes the goal state. When there are no goals
left, the proof is done.

Replace each `sorry` with a proof. A file with no `sorry` warnings and no errors is a solved sheet.

Reading for this sheet: *Mathematics in Lean*, chapter 2.1 ("Calculating") and 2.2.
-/

namespace LeanLearning.Week01

/-! ## Worked examples -/

/-- `rfl` proves an equation whose two sides compute to the same value. -/
example : 2 + 2 = 4 := rfl

/-- `rw [h]` replaces the left side of `h` with its right side, everywhere in the goal.
After rewriting, `rw` tries `rfl` on its own, which closes this goal. -/
example (a b : ℕ) (h : a = b) : a + 1 = b + 1 := by
  rw [h]

/-- You can rewrite with several equations in a row. -/
example (a b c : ℕ) (h₁ : a = b) (h₂ : b = c) : a = c := by
  rw [h₁, h₂]

/-- `rw [← h]` rewrites right-to-left instead. -/
example (a b : ℕ) (h : a = b) : b * 2 = a * 2 := by
  rw [← h]

/-- `ring` proves any equation that holds in every commutative ring, by algebra alone. -/
example (a b : ℕ) : (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 := by
  ring

/-- `rw [...] at h` rewrites inside a hypothesis instead of the goal, and `exact h` closes a goal
that is exactly `h`. -/
example (a b : ℕ) (h : a + 0 = b) : a = b := by
  rw [Nat.add_zero] at h
  exact h

/-! ## Exercises -/

theorem ex1_1 (a b : ℕ) (h : a = 3) (h' : b = a) : b = 3 := by
  sorry

theorem ex1_2 (a b c d : ℕ) (hab : a = b) (hcd : c = d) : a + c = b + d := by
  sorry

/-- Hint: rewrite with `h`, then the goal is plain algebra. -/
theorem ex1_3 (x y : ℕ) (h : x = y + 2) : x + 1 = y + 3 := by
  sorry

theorem ex1_4 (a b : ℤ) : (a - b) * (a + b) = a ^ 2 - b ^ 2 := by
  sorry

/-- Hint: rewrite with `h` *backwards*, or rewrite `h` into the goal's shape first. -/
theorem ex1_5 (a b c : ℤ) (h : a = b + c) : a - c = b := by
  sorry

/-- A polynomial identity of the kind that drives algebraic complexity: the left side
needs one multiplication (a squaring), the right side written out needs several.
Two formulas, one polynomial, different costs. That gap is what VP and VNP measure. -/
theorem ex1_6 (x y z : ℤ) : (x + y + z) ^ 2 = x ^ 2 + y ^ 2 + z ^ 2 + 2 * (x * y + y * z + z * x) := by
  sorry

end LeanLearning.Week01

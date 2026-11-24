import Mathlib.Tactic.Ring

/-!
# Week 1, sheet 2: logic

In Lean a statement is a *type*, and a proof of it is a *term* of that type. A proof of
`P → Q` is a function that turns proofs of `P` into proofs of `Q`. That is why `intro`
(take an argument) and `exact` (give the answer) are the two moves you'll use most.

| To prove...  | Use                                | To use a hypothesis `h : ...` | Use                          |
|--------------|------------------------------------|-------------------------------|------------------------------|
| `P → Q`      | `intro hP`                         | `P → Q`                       | `h hP`, or `apply h`         |
| `P ∧ Q`      | `constructor`, or `exact ⟨hP, hQ⟩` | `P ∧ Q`                       | `h.1`, `h.2`, `obtain ⟨hP, hQ⟩ := h` |
| `P ∨ Q`      | `left` or `right`                  | `P ∨ Q`                       | `rcases h with hP \| hQ`     |
| `¬P`         | `intro hP` (then prove `False`)    | `¬P`                          | `h hP : False`               |
| `∀ x, p x`   | `intro x`                          | `∀ x, p x`                    | `h a : p a`                  |
| `∃ x, p x`   | `use a` or `exact ⟨a, ha⟩`         | `∃ x, p x`                    | `obtain ⟨x, hx⟩ := h`        |

Reading for this sheet: *Mathematics in Lean*, chapter 3 ("Logic"), sections 3.1 to 3.5.
-/

namespace LeanLearning.Week01

/-! ## Worked examples -/

example (P Q : Prop) (hP : P) (hPQ : P → Q) : Q := by
  exact hPQ hP

example (P Q : Prop) : P ∧ Q → P := by
  intro h
  exact h.1

example (P Q : Prop) (hP : P) : Q ∨ P := by
  right
  exact hP

/-- `¬P` is defined as `P → False`, so `intro` works on it. -/
example (P : Prop) (hP : P) : ¬¬P := by
  intro hnP
  exact hnP hP

example (α : Type) (p : α → Prop) (a : α) (h : ∀ x, p x) : ∃ x, p x := by
  exact ⟨a, h a⟩

/-! ## Exercises -/

theorem ex2_1 (P Q : Prop) (hP : P) (hQ : Q) : P ∧ Q := by
  sorry

theorem ex2_2 (P Q : Prop) : P ∧ Q → Q ∧ P := by
  sorry

theorem ex2_3 (P Q R : Prop) (hPQ : P → Q) (hQR : Q → R) : P → R := by
  sorry

theorem ex2_4 (P Q : Prop) : P ∨ Q → Q ∨ P := by
  sorry

theorem ex2_5 (P Q : Prop) : (P → Q) → ¬Q → ¬P := by
  sorry

theorem ex2_6 (P : Prop) : ¬¬¬P → ¬P := by
  sorry

theorem ex2_7 (α : Type) (p q : α → Prop) : (∀ x, p x ∧ q x) → ∀ x, p x := by
  sorry

theorem ex2_8 (α : Type) (p q : α → Prop) : (∃ x, p x ∧ q x) → ∃ x, p x := by
  sorry

/-- The shape of every lower bound in `vp-vnp/Statement.lean`:
"there is a constant, and a threshold, beyond which something holds".
Here: some `n₀` beyond which `n + 1` exceeds 10. Hint: `use 10`, then `intro`, then `omega`. -/
theorem ex2_9 : ∃ n₀ : ℕ, ∀ n ≥ n₀, 10 < n + 1 := by
  sorry

end LeanLearning.Week01

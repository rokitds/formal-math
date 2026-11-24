"""Week 1 scene: a Lean proof seen from the inside.

Left: the proof, with the current tactic highlighted.
Right: the goal state Lean shows in the Infoview after that tactic.

The proof is the third worked example in learning/lean/LeanLearning/Week01/E03_Sets.lean.
The goal states below were copied from Lean's output (`trace_state`), with the lines
`α : Type u_1` and `s : Set α` left out to save space. Everything else is what the learner sees.

Render (no LaTeX needed, this scene uses only plain text):
    manim -pql goal_state.py GoalState      # quick preview, 480p
    manim -qh goal_state.py GoalState       # 1080p for a video
"""

from manim import (
    DOWN,
    LEFT,
    RIGHT,
    UP,
    UL,
    BLUE_D,
    GREEN_C,
    GREY_B,
    YELLOW,
    Code,
    FadeIn,
    FadeOut,
    ReplacementTransform,
    RoundedRectangle,
    Scene,
    SurroundingRectangle,
    Text,
    Write,
)

MONO = "DejaVu Sans Mono"

PROOF = """example : s ∩ s = s := by
  ext x
  constructor
  · intro hx
    exact hx.1
  · intro hx
    exact ⟨hx, hx⟩"""

# One entry per proof line: (line index in PROOF, goal state after that line, caption).
STEPS = [
    (0, "⊢ s ∩ s = s",
     "The goal: two sets are equal."),
    (1, "x : α\n⊢ x ∈ s ∩ s ↔ x ∈ s",
     "ext: sets are equal when they have the same elements."),
    (2, "case mp\nx : α\n⊢ x ∈ s ∩ s → x ∈ s\n\ncase mpr\nx : α\n⊢ x ∈ s → x ∈ s ∩ s",
     "constructor: an ↔ splits into two goals, one per direction."),
    (3, "case mp\nx : α\nhx : x ∈ s ∩ s\n⊢ x ∈ s",
     "· focuses on the first goal. intro: assume x ∈ s ∩ s, call it hx."),
    (4, "case mpr\nx : α\n⊢ x ∈ s → x ∈ s ∩ s",
     "exact hx.1: the left half of hx is the goal. One goal left."),
    (5, "case mpr\nx : α\nhx : x ∈ s\n⊢ x ∈ s ∩ s",
     "intro: assume x ∈ s."),
    (6, "No goals",
     "exact ⟨hx, hx⟩: x is in both sides of the intersection. Done."),
]


def goal_text(state: str) -> Text:
    color = GREEN_C if state == "No goals" else None
    kwargs = {"font": MONO, "font_size": 24, "line_spacing": 0.8}
    if color:
        kwargs["color"] = color
    return Text(state, **kwargs)


class GoalState(Scene):
    def construct(self):
        title = Text("A Lean proof, seen from the inside", font_size=34).to_edge(UP)

        code = Code(
            code_string=PROOF,
            language="lean4",
            formatter_style="monokai",
            add_line_numbers=False,
            paragraph_config={"font": MONO, "font_size": 24},
        )
        code.to_edge(LEFT, buff=0.5).shift(DOWN * 0.2)

        panel = RoundedRectangle(width=6.0, height=4.6, corner_radius=0.15, color=BLUE_D)
        panel.to_edge(RIGHT, buff=0.5).shift(DOWN * 0.2)
        panel_label = Text("Infoview: goal state", font_size=20, color=BLUE_D)
        panel_label.next_to(panel, UP, buff=0.1).align_to(panel, LEFT)

        self.play(Write(title))
        self.play(FadeIn(code), FadeIn(panel), FadeIn(panel_label))

        highlight = None
        goal = None
        caption = None
        for line, state, text in STEPS:
            new_highlight = SurroundingRectangle(code.code_lines[line], color=YELLOW, buff=0.06)
            new_goal = goal_text(state).move_to(panel).align_to(panel, UL).shift(RIGHT * 0.3 + DOWN * 0.3)
            new_caption = Text(text, font_size=24, color=GREY_B).to_edge(DOWN, buff=0.4)

            if goal is None:
                self.play(FadeIn(new_highlight), FadeIn(new_goal), FadeIn(new_caption))
            else:
                self.play(
                    ReplacementTransform(highlight, new_highlight),
                    ReplacementTransform(goal, new_goal),
                    ReplacementTransform(caption, new_caption),
                )
            highlight, goal, caption = new_highlight, new_goal, new_caption
            self.wait(1.5)

        self.play(FadeOut(highlight))
        self.wait(1)


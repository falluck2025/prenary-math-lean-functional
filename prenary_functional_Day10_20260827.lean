import Mathlib

/- ================================================================
   偏元数学 · 泛函分析（Day 10 · 三柱综合版 · 修复2 · 具体ℝ版）
   核心：对象层（经典范数/内积/算子）不动，动作层（偏元版本）留 ε
   三根柱子：范数 + 内积 + 算子（本稿用具体 ℝ 验证核心，后续推广抽象空间）
   新结构：动作留差破坏"齐次性"（范数）、"双线性"（内积）、"线性"（算子）
   ================================================================ -/

noncomputable def prenary_norm (x : ℝ) (ε : ℝ) : ℝ :=
  ‖x‖ + ε

noncomputable def prenary_inner (x y : ℝ) (ε : ℝ) : ℝ :=
  x * y + ε

noncomputable def prenary_operator (f : ℝ → ℝ) (x : ℝ) (ε : ℝ) : ℝ :=
  f x + ε

-- ==================== 范数柱 ====================

theorem prenary_norm_degenerate (x : ℝ) :
    prenary_norm x 0 = ‖x‖ := by
  unfold prenary_norm
  rw [add_zero]

theorem prenary_norm_non_trivial (x : ℝ) {ε : ℝ} (hε : ε ≠ 0) :
    prenary_norm x ε ≠ ‖x‖ := by
  intro h
  unfold prenary_norm at h
  have hε0 : ε = 0 := by
    linarith
  exact hε hε0

theorem prenary_norm_triangle (x y : ℝ) {ε : ℝ} (hε : 0 ≤ ε) :
    prenary_norm (x + y) ε ≤ prenary_norm x ε + prenary_norm y ε := by
  unfold prenary_norm
  have h := norm_add_le x y
  linarith

theorem prenary_norm_not_homogeneous :
    ∃ c : ℝ, c ≠ 1 ∧ prenary_norm (c * 1) 1 ≠ |c| * prenary_norm 1 1 := by
  refine ⟨2, by norm_num, ?_⟩
  unfold prenary_norm
  norm_num

-- ==================== 内积柱 ====================

theorem prenary_inner_degenerate (x y : ℝ) :
    prenary_inner x y 0 = x * y := by
  unfold prenary_inner
  rw [add_zero]

theorem prenary_inner_non_trivial (x y : ℝ) {ε : ℝ} (hε : ε ≠ 0) :
    prenary_inner x y ε ≠ x * y := by
  intro h
  unfold prenary_inner at h
  have hε0 : ε = 0 := by
    linarith
  exact hε hε0

theorem prenary_inner_not_bilinear :
    prenary_inner (1 + 1) 1 1 ≠ prenary_inner 1 1 1 + prenary_inner 1 1 1 := by
  unfold prenary_inner
  norm_num

-- ==================== 算子柱 ====================

theorem prenary_operator_degenerate (f : ℝ → ℝ) (x : ℝ) :
    prenary_operator f x 0 = f x := by
  unfold prenary_operator
  rw [add_zero]

theorem prenary_operator_non_trivial (f : ℝ → ℝ) (x : ℝ) {ε : ℝ} (hε : ε ≠ 0) :
    prenary_operator f x ε ≠ f x := by
  intro h
  unfold prenary_operator at h
  have hε0 : ε = 0 := by
    linarith
  exact hε hε0

theorem prenary_operator_not_linear :
    prenary_operator (fun x : ℝ => x) (1 + 1) 1 ≠
      prenary_operator (fun x : ℝ => x) 1 1 + prenary_operator (fun x : ℝ => x) 1 1 := by
  unfold prenary_operator
  norm_num

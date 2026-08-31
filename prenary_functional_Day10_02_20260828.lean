import Mathlib

/- ================================================================
   偏元数学 · 泛函分析 Day10-02（抽象版）
   把 Day10（具体 ℝ 版）推广到抽象空间 X，为无穷维（希尔伯特空间）铺路。
   注：内积入口用 inner ℝ x y（class Inner (𝕜 E) 字段签名 inner (𝕜) : E → E → 𝕜，𝕜 显式）。
   ================================================================ -/

noncomputable section

variable {X : Type*} [SeminormedAddCommGroup X] [InnerProductSpace ℝ X]

-- ---------- 三柱定义 ----------
noncomputable def prenary_norm (x : X) (ε : ℝ) : ℝ :=
  ‖x‖ + ε

noncomputable def prenary_inner (x y : X) (ε : ℝ) : ℝ :=
  inner ℝ x y + ε

noncomputable def prenary_operator (f : X →ₗ[ℝ] X) (e : X) (x : X) (ε : ℝ) : X :=
  f x + ε • e

-- ---------- 范数柱 ----------
theorem prenary_norm_degenerate (x : X) :
    prenary_norm x 0 = ‖x‖ := by
  unfold prenary_norm
  rw [add_zero]

theorem prenary_norm_non_trivial (x : X) {ε : ℝ} (hε : ε ≠ 0) :
    prenary_norm x ε ≠ ‖x‖ := by
  intro h
  unfold prenary_norm at h
  have hε0 : ε = 0 := by linarith
  exact hε hε0

theorem prenary_norm_triangle (x y : X) {ε : ℝ} (hε : 0 ≤ ε) :
    prenary_norm (x + y) ε ≤ prenary_norm x ε + prenary_norm y ε := by
  unfold prenary_norm
  have h := norm_add_le x y
  linarith

theorem prenary_norm_not_homogeneous :
    ∃ c : ℝ, c ≠ 1 ∧ prenary_norm (c • (1 : ℝ)) 1 ≠ ‖c‖ * prenary_norm (1 : ℝ) 1 := by
  refine ⟨2, by norm_num, ?_⟩
  unfold prenary_norm
  norm_num

-- ---------- 内积柱 ----------
theorem prenary_inner_degenerate (x y : X) :
    prenary_inner x y 0 = inner ℝ x y := by
  unfold prenary_inner
  rw [add_zero]

theorem prenary_inner_non_trivial (x y : X) {ε : ℝ} (hε : ε ≠ 0) :
    prenary_inner x y ε ≠ inner ℝ x y := by
  intro h
  unfold prenary_inner at h
  have hε0 : ε = 0 := by linarith
  exact hε hε0

theorem prenary_inner_not_bilinear :
    prenary_inner ((1 : ℝ) + (1 : ℝ)) (1 : ℝ) 1 ≠
      prenary_inner (1 : ℝ) (1 : ℝ) 1 + prenary_inner (1 : ℝ) (1 : ℝ) 1 := by
  unfold prenary_inner
  norm_num

-- ---------- 算子柱 ----------
theorem prenary_operator_degenerate (f : X →ₗ[ℝ] X) (e x : X) :
    prenary_operator f e x 0 = f x := by
  unfold prenary_operator
  simp

theorem prenary_operator_non_trivial (f : X →ₗ[ℝ] X) (e x : X) {ε : ℝ}
    (hε : ε ≠ 0) (he : e ≠ 0) :
    prenary_operator f e x ε ≠ f x := by
  intro h
  unfold prenary_operator at h
  have h0 : ε • e = 0 := by
    have h' : f x + ε • e = f x + 0 := by simpa using h
    exact add_left_cancel h'
  have h_or : ε = 0 ∨ e = 0 := smul_eq_zero.mp h0
  cases h_or with
  | inl hε0 => exact hε hε0
  | inr he0 => exact he he0

theorem prenary_operator_not_linear :
    prenary_operator (LinearMap.id : ℝ →ₗ[ℝ] ℝ) (1 : ℝ) ((1 : ℝ) + (1 : ℝ)) 1 ≠
      prenary_operator (LinearMap.id : ℝ →ₗ[ℝ] ℝ) (1 : ℝ) (1 : ℝ) 1 +
      prenary_operator (LinearMap.id : ℝ →ₗ[ℝ] ℝ) (1 : ℝ) (1 : ℝ) 1 := by
  unfold prenary_operator
  norm_num

end

import data.real.basic

section
variables a b c d : ℝ

#check (min_le_left a b : min a b ≤ a)
#check (min_le_right a b : min a b ≤ b)
#check (le_min : c ≤ a → c ≤ b → c ≤ min a b)

example : min a b = min b a :=
begin
  apply le_antisymm,
  { show min a b ≤ min b a,
    apply le_min,
    { apply min_le_right },
    apply min_le_left },
  { show min b a ≤ min a b,
    apply le_min,
    { apply min_le_right },
    apply min_le_left }
end

example : min a b = min b a :=
begin
  have h : ∀ x y, min x y ≤ min y x,
  { intros x y,
    apply le_min,
    apply min_le_right,
    apply min_le_left },
  apply le_antisymm, apply h, apply h
end

example : min a b = min b a :=
begin
  apply le_antisymm,
  repeat {
    apply le_min,
    apply min_le_right,
    apply min_le_left }
end

example : max a b = max b a :=
begin
  apply ge_antisymm,
  repeat {
    apply max_le,
    apply le_max_right,
    apply le_max_left,
  }
end

example : min (min a b) c = min a (min b c) :=
begin
  apply le_antisymm,
  {
    apply le_min,
    {
      apply le_trans,
      apply min_le_left,
      apply min_le_left,
    },
    {
      apply le_min,
      {
        apply le_trans,
        apply min_le_left,
        apply min_le_right,
      },
      {
        apply min_le_right,
      }
    },
  },
  {
    apply le_min,
    {
      apply le_min,
      {
        apply min_le_left,
      },
      {
        apply le_trans,
        apply min_le_right,
        apply min_le_left,
      }
    },
    {
      apply le_trans,
      apply min_le_right,
      apply min_le_right,
    },
  },
end

lemma aux : min a b + c ≤ min (a + c) (b + c) :=
begin
  apply le_min,
  {
    apply add_le_add,
    apply min_le_left,
    apply le_refl,
  },
  {
    apply add_le_add,
    apply min_le_right,
    apply le_refl,
  },
end

#check add_le_add_right
example : min a b + c = min (a + c) (b + c) :=
begin
  apply le_antisymm,
  apply aux,
  rw <-add_zero (min (a + c)(b + c)),
  rw <-sub_self c,
  rw sub_eq_add_neg,
  rw add_comm c,
  rw <-add_assoc,
  apply add_le_add_right,
  nth_rewrite 1 <-add_neg_cancel_right a c,
  nth_rewrite 1 <-add_neg_cancel_right b c,
  apply aux,
end

#check (abs_add : ∀ a b : ℝ, abs (a + b) ≤ abs a + abs b)
#check sub_add_cancel
#check le_abs

example : abs a - abs b ≤ abs (a - b) :=
begin
  sorry,
end

end

section
variables w x y z : ℕ

example (h₀ : x ∣ y) (h₁ : y ∣ z) : x ∣ z :=
dvd_trans h₀ h₁

example : x ∣ y * x * z :=
begin
  apply dvd_mul_of_dvd_left,
  apply dvd_mul_left
end

example : x ∣ x^2 :=
by apply dvd_mul_right

#check dvd_add
example (h : x ∣ w) : x ∣ y * (x * z) + x^2 + w^2 :=
begin
  repeat { apply dvd_add },
  {
    apply dvd_mul_of_dvd_right,
    apply dvd_mul_right,
  },
  apply dvd_mul_right,
  {
    apply dvd_mul_of_dvd_left,
    apply h,
  }
end

end

section
variables m n : ℕ
open nat

#check (gcd_zero_right n : gcd n 0 = n)
#check (gcd_zero_left n  : gcd 0 n = n)
#check (lcm_zero_right n : lcm n 0 = 0)
#check (lcm_zero_left n  : lcm 0 n = 0)

example : gcd m n = gcd n m :=
begin
  apply dvd_antisymm,
  apply dvd_gcd,
  apply gcd_dvd_right,
  apply gcd_dvd_left,
  apply dvd_gcd,
  apply gcd_dvd_right,
  apply gcd_dvd_left,
end

end

def fibs(positions)
  sequence = [0, 1]

  a = 1
  b = 0
  (positions - 2).times do
    sequence << a + b
    b = a
    a = sequence[-1]
  end

  sequence[0..positions]
end

def fibs_rec(positions, sequence = [0, 1])
  sequence << sequence[-1] + sequence[-2] if positions > 2
  fibs_rec(positions - 1, sequence) if positions > 2
  positions <= 1 ? [0] : sequence
end

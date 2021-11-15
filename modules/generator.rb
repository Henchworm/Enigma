module Generator

  def key_generator
   rand(99999).to_s.rjust(5, '0')
  end

  def offset_generator(date = Date.today)
    if date.class == Date
     formatted = date.strftime("%-d,%-m,%y").gsub(/,/, '')
     (formatted.to_i ** 2).to_s.split("").last(4)
   else
     (date.to_i ** 2).to_s.split("").last(4)
    end.join
  end

  def shift(randkey = key_generator, offset = offset_generator)
    key_pairs = randkey.split("").map(&:to_i).each_cons(2).map {|a| a.join.to_i}
    shift_hash = {
      "A" => (key_pairs[0] + offset[0].to_i),
      "B" => (key_pairs[1] + offset[1].to_i),
      "C" => (key_pairs[2] + offset[2].to_i),
      "D" => (key_pairs[3] + offset[3].to_i)
    }
  end
end
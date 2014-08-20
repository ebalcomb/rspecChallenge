def make_maru
  Kitten.new.tap do |kitten|
    kitten.set_name('Maru')
  end
end

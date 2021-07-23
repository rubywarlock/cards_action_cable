['always', '5s', '25s', '2min', '10min', '1h', '5h', '1d', '5d', '25d', '4m', 'never'].each_with_index do |interval, index|
  interval_type, level = interval, index
  group = Group.find_or_initialize_by(interval_type: interval_type)
  group.level = level.to_s
  group.save
end
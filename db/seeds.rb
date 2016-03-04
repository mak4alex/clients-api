1000.times do
  Client.create!(
      {
          name: Faker::Name.name,
          sex: Faker::Boolean.boolean,
          id_number: "ID#{Faker::Number.number(7)}",
          phone: "+#{rand(1..999)}(#{rand(1..99)})#{Faker::Number.number(7)}",
          address: "#{ Faker::Address.city } #{ Faker::Address.street_address} "
      }
  )
end
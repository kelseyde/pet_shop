require_relative('camelot_data.rb')
require_relative('camelot_functions.rb')

app_running = true

while app_running

  puts "Welcome to Camelot of Pets, an interactive Ruby pet shop! What would
you like to do? Type 'see options' to see your options."
  answer = gets.chomp.downcase

  case answer

    when answer = "see options"
      puts "These are your options:
      - pet shop name
      - total cash
      - add cash
      - remove cash
      - view pets
      - view customers
      - pets sold
      - increase pets sold
      - stock count
      - pets by breed
      - find pet by name
      - remove pet by name
      - add pet to stock
      - customer pet count
      - add pet to customer
      - customer can afford pet
      - sell pet to customer
      - quit"
      puts

    when answer = "pet shop name"
      puts "The pet shop is called \"#{pet_shop[:name]}\""
      puts

    when answer = "total cash"
      puts "#{pet_shop[:name]} has £#{pet_shop[:admin][:total_cash]}."
      puts

    when answer = "add cash"
      puts "How much cash would you like to add?"
      cash = gets.chomp.to_i
      add_or_remove_cash(pet_shop, -cash)
      puts "£#{cash.to_s} has been added to #{pet_shop[:name]}. Total
      cash is now #{pet_shop[:admin][:total_cash]}."
      puts

    when answer = "remove cash"
      puts "How much cash would you like to remove?"
      cash = -(gets.chomp.to_i)
      add_or_remove_cash(pet_shop, cash)
      puts "£#{cash.to_s} has been removed from #{pet_shop[:name]}! Total
      cash is now #{pet_shop[:admin][:total_cash]}."
      puts

    when answer = "view pets"
      puts "These are the pets currently in stock:"
      puts
      for pet in pet_shop[:pets] do
        puts "name: #{pet[:name]}"
        puts "pet type: #{pet[:pet_type]}"
        puts "breed: #{pet[:breed]}"
        puts "price: #{pet[:price]}"
        puts
      end

    when answer = "view customers"
      puts "These are the customers in the pet shop:"
      puts
      for customer in customers do
        puts "name: #{customer[:name]}"
        puts "pets: #{customer[:pets].count}"
        puts "cash: #{customer[:cash]}"
        puts
      end

    when answer = "pets sold"
      puts "The number of pets sold is #{pet_shop[:admin][:pets_sold]}."
      puts

    when answer = "increase pets sold"
      puts "How many new pets have been sold?"
      answer = gets.chomp.to_i
      increase_pets_sold(pet_shop, answer)
      puts "The pet shop has been updated. The total number of pets sold is now"\
      " #{pet_shop[:admin][:pets_sold]}."
      puts

    when answer = "stock count"
      puts "The number of pets in stock is #{stock_count(pet_shop)}."
      puts

    when answer = "pets by breed"
      puts "What breed would you like to check?"
      answer = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
      breed_array = pets_by_breed(pet_shop, answer)
      puts "There are #{breed_array.count} pets of the breed #{answer}."
      puts

    when answer = "find pet by name"
      puts "What is the name of the pet you'd like to search for?"
      answer = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
      pet = find_pet_by_name(pet_shop, answer)
      if pet == nil
        puts "There is no pet called #{answer}."
      elsif pet[:gender] = :male
        puts "#{pet[:name]} is a #{pet[:breed]}. He costs #{pet[:price]}."
      else
        puts "#{pet[:name]} is a #{pet[:breed]}. She costs #{pet[:price]}."
      end
      puts

    when answer = "remove pet by name"
      puts "What is the name of the pet you'd like to remove?"
      pet_name = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
      pet_match = false

      for pet in pet_shop[:pets]
        pet_match = true if pet[:name] == pet_name
      end

      if pet_match == false
        puts "The pet shop doesn't have a pet called #{pet_name}."
      else
        remove_pet_by_name(pet_shop, pet_name)
        puts "#{pet_name} has been removed from stock."
        puts
      end

    when answer = "add pet to stock"
      puts "What is the name of the pet you'd like to add?"
      name = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
      puts "What type of pet is #{name}?"
      pet_type = gets.chomp.to_sym
      puts "What breed is #{name}?"
      breed = gets.chomp.to_sym
      puts "What gender is #{name}?"
      gender = gets.chomp.to_sym
      puts "What price is #{name}?"
      price = gets.chomp.to_i

      new_pet = {
        name: name,
        pet_type: pet_type,
        breed: breed,
        gender: gender,
        price: price
      }
      pet_shop[:pets].push(new_pet)

      puts "Thank you. #{name} has been added to #{pet_shop[:name]}!"
      puts

    when answer = "customer pet count"
      puts "Which customer's pet count would you like to check?"
      customer_name = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")

      name_match = false
      for customer in customers
        if customer[:name] == customer_name
          name_match = true
          customer_hash = customer
        end
      end

      if name_match == false
        puts "There is no customer called #{customer_name}."
      else
        pet_count = customer_pet_count(customer_hash)
        puts "#{customer_name} has #{pet_count.to_s} pets."
      end

    when answer = "add pet to customer"
      puts "which customer is getting a pet?"
      customer_name = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
      #checking if the customer exists...t
      name_match = false
      for customer in customers
        if customer[:name] == customer_name
          name_match = true
          customer_hash = customer
        end
      end

      if name_match == false
        puts "There is no customer called #{customer_name}."
      else
        puts "And which pet would you like to give them?"
        pet_name = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
        #checking if the pet exists...
        name_match = false
        for pet in pet_shop[:pets]
          if pet[:name] == pet_name
            name_match = true
            pet_hash = pet
          end
        end
      end

        if name_match == false
          puts "There is no pet called #{pet_name}."
        else
          add_pet_to_customer(customer_hash, pet_hash)
          puts "#{pet_name} has been added to #{customer_name}!"
        end


    when answer = "customer can afford pet"
      puts "Which customer do you want to check?"
      customer_name = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
      #checking if the customer exists...
      name_match = false
      for customer in customers
        if customer[:name] == customer_name
          name_match = true
          customer_hash = customer
        end
      end

      if name_match == false
        puts "There is no customer called #{customer_name}."
      else
        puts "And which pet would you like to check?"
        pet_name = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
        #checking if the pet exists...
        name_match = false
        for pet in pet_shop[:pets]
          if pet[:name] == pet_name
            name_match = true
            pet_hash = pet
          end
        end

        if name_match == false
          puts "There is no pet called #{pet_name}."
        elsif customer_can_afford_pet(customer_hash, pet_hash) == false
          puts "#{customer_name} cannot afford #{pet_name}. #{customer_name} "\
          "has #{customer_hash[:cash]}, whereas #{pet_name} costs #{pet_hash [:price]}."
          puts
        else
          puts "#{customer_name} can afford #{pet_name}!"
        end
      end


    when answer = "sell pet to customer"
      puts "Which customer wants to buy a pet?"
      customer_name = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
      #checking if the customer exists...
      name_match = false
      for customer in customers
        if customer[:name] == customer_name
          name_match = true
          customer_hash = customer
        end
      end

      if name_match == false
        puts "There is no customer called #{customer_name}."
      else
        puts "And which pet would #{customer_name} like to buy?"
        pet_name = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
        #checking if the pet exists...
        name_match = false
        for pet in pet_shop[:pets]
          if pet[:name] == pet_name
            name_match = true
            pet_hash = pet
          end
        end

        if name_match == false
          puts "There is no pet called #{pet_name}."
        elsif customer_hash[:cash] < pet_hash[:price]
          puts "The customer has insufficient funds. #{customer_name} has "\
          "#{customer_hash[:cash]}, whereas #{pet_name} costs #{pet_hash[:price]}."
          puts
        else
          pet_shop[:admin][:total_cash] += pet_hash[:price]
          customer_hash[:cash] -= pet_hash[:price]
          pet_shop[:pets].delete(pet_hash)
          customer_hash[:pets].push(pet_hash)
          pet_shop[:admin][:pets_sold] += 1
          puts "#{customer_name} has purchased #{pet_name}!"
          puts
        end
      end

    when answer = "quit"
      app_running = false
      puts "Goodbye"

  end

end

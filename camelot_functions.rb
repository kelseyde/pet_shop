def pet_shop_name(pet_shop)
  return pet_shop[:name]
end

def total_cash(pet_shop)
  return pet_shop[:admin][:total_cash]
end

def add_or_remove_cash(pet_shop, cash)
  pet_shop[:admin][:total_cash] += cash
  return pet_shop[:admin][:total_cash]
end

def pets_sold(pet_shop)
  return pet_shop[:admin][:pets_sold]
end

def increase_pets_sold(pet_shop, number_sold)
  pet_shop[:admin][:pets_sold] += number_sold
  return pet_shop[:admin][:pets_sold]
end

def stock_count(pet_shop)
  return pet_shop[:pets].length
end

def pets_by_breed(pet_shop, case_breed)
  breed_array = []
  for pet in pet_shop[:pets] do
    breed_array.push(pet[:name]) if pet[:breed] == case_breed
  end
  return breed_array
end

def find_pet_by_name(pet_shop, pet_name)
  for pet in pet_shop[:pets] do
    return pet if pet_name == pet[:name]
  end
  return nil
end

def remove_pet_by_name(pet_shop, pet_name)
  for pet in pet_shop[:pets]
    if pet[:name] == pet_name
      pet_shop[:pets].delete(pet)
    end
  end
end

def add_pet_to_stock (pet_shop, new_pet)
  pet_shop[:pets].push(new_pet)
end

def customer_pet_count(customer)
  return customer[:pets].count
end

def add_pet_to_customer(customer, new_pet)
  customer[:pets].push(new_pet)
end

def customer_can_afford_pet (customer, new_pet)
  return customer[:cash] >= new_pet[:price]
end

def sell_pet_to_customer(pet_shop, pet, customer)
  return false if !pet
  found_pet = find_pet_by_name(pet_shop, pet[:name])
  return false if !found_pet
  if customer[:cash] >= pet[:price]
    pet_shop[:admin][:total_cash] += pet[:price]
    customer[:cash] -= pet[:price]
    pet_shop[:pets].delete(pet)
    customer[:pets].push(pet)
    pet_shop[:admin][:pets_sold] += 1
  end
end

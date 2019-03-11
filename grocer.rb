def consolidate_cart(cart)
  # code here
  hash = {}
  cart.each do |item|
    item.each do |hash_name, hash_info|
        if hash[hash_name].nil? 
          hash[hash_name] = hash_info.merge({:count => 1})
          else
            hash[hash_name][:count] += 1 
          end 
        end
      end
    hash 
end

def apply_coupons(cart, coupons)
  # code here
  new_hash = {}
  cart.each do |name, info|
    coupons.each do |coupon|
      if name == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] = info[:count] - coupon[:num]
        if new_hash["#{name} W/COUPON"] 
          new_hash["#{name} W/COUPON"][:count] += 1 
        else
          new_hash["#{name} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1 }
        end 
      end 
    end 
    new_hash[name] = info
  end
    new_hash
end

def apply_clearance(cart)
  # code here
  new_cart = {}
  cart.each do |name, info|
    new_cart[name] = {}
      if info[:clearance] == true
       new_cart[name][:price] = info[:price] - (info[:price]*0.2)
     else 
       new_cart[name][:price] = info[:price]
     end 
     new_cart[name][:clearance]= info[:clearance]
     new_cart[name][:count]= info[:count]
   end
   new_cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
   total = 0 
   cart.each do |item, info|
       total += info[:price] * info[:count]
     end
       if total > 100 
         total = total - (total * 0.1)
         total
     end
end

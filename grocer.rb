def consolidate_cart(cart)
    newHashCart = {}
    cart.each do |itemHash,keysOfItem|
      itemHash.each do |newNameOfItem,newKeysOfItem|
        if newHashCart[newNameOfItem]
          newHashCart[newNameOfItem][:count]+= 1
        else 
          newHashCart[newNameOfItem] = newKeysOfItem
          newHashCart[newNameOfItem][:count] = 1
        end
      end
    end
    newHashCart   
end


def apply_coupons(cart, coupons)
  result = {}
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] =  info[:count] - coupon[:num]
        if result["#{food} W/COUPON"]
          result["#{food} W/COUPON"][:count] += 1
        else
          result["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    result[food] = info
  end
  result
end	


def apply_clearance(cart)
  clearance_cart = {}
  cart.each do |food, info|
    clearance_cart[food] = {}
    if info[:clearance] == true
      clearance_cart[food][:price] = info[:price] * 4 / 5
    else
      clearance_cart[food][:price] = info[:price]
    end
    clearance_cart[food][:clearance] = info[:clearance]
    clearance_cart[food][:count] = info[:count]
  end
  clearance_cart
end	

def checkout(cart, coupons)
  #cart = consolidate_cart(cart: cart)
end 	  cart = apply_coupons(cart: cart, coupons: coupons)
  cart = apply_clearance(cart: cart)
  result = 0
  cart.each do |food, info|
    result += (info[:price] * info[:count]).to_f
  end
  result > 100 ? result * 0.9 : result
end
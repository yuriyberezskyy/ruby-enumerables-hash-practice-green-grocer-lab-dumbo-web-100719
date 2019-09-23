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
  consolidate_cart(cart)
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon
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
  
end

def checkout(cart, coupons)
   
end

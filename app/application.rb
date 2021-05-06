class Application
  @@items = [Item.new("tacos", 2.00)]
  def call(env)
    resp = Rack::Response.new 
    req = Rack::Request.new(env)
    
    if req.path.split('/')[1] == 'items'
      item_name = req.path.split('/').last 
      found_item_price = nil
      @@items.each do |item| 
        if item.name == item_name
          found_item_price = item.price 
        end
        if !found_item_price
          resp.status = 400
          resp.write "Item not found"
        else 
          resp.write found_item_price
        end
      end
    else 
      resp.write "Route not found"
      resp.status = 404
    end
    # binding.pry 
    
    resp.finish
  end
end
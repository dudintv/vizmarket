class TestController < ApplicationController
  layout 'test'
  
  def test
  end

  def images
    @product = Product.first
  end
end

class ProductDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  # Product images:

  def thumbnail
    if object.thumbnail.attached?
      object.thumbnail.variant(combine_options: { gravity: 'center', resize: '568^', crop: '568x568+0+0' }) 
    else
      '/images/svg/default-product.svg'
    end
  end

  def featured_image
    if object.featured_image.attached?
      object.featured_image.variant(combine_options: { gravity: 'center', resize: '568^', crop: '568x568+0+0' }) 
    else
      '/images/svg/default-product.svg'
    end
  end

end

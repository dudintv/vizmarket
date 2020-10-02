class AddAuthorToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :author, foreign_key: true
    if Product.unscoped.count > 0
      author_id = Author.first_or_create.id
      Product.all.each do |product|
        product.author_id = author_id
        product.save
      end
    end
    change_column_null :products, :author_id, false
  end
end

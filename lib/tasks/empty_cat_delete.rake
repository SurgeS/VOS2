namespace :db do
  desc 'Delete products with empty string category'
  task delete_empty: :environment do
    Product.destroy_all(category: '')
  end
end
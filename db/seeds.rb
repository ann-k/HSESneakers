# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rake::Task['db:drop'].invoke
Rake::Task['db:create'].invoke
Rake::Task['db:migrate'].invoke

def random_brand_id
  Brand.offset(rand(Brand.count)).first.id
end

def upload_fake_image
  uploader = ImageUploader.new(Sneaker.new, :image)
  uploader.cache!(File.open(Dir.glob(File.join(Rails.root, 'lib/tasks/sneakers', '*')).sample))
  uploader
end

Brand.create([
  {
    name: 'Adidas'
  }, {
    name: 'New Balance'
  }, {
    name: 'Nike'
  }, {
    name: 'Puma'
  }
])

@sneaker_models = ['кроссовок1', 'кроссовок2', 'кроссовок3']

@sneaker_sex = ['male', 'female', '-']

def sneaker_price
  rand(1900..20000)
end

def create_sneaker
  Sneaker.create(
    model:    @sneaker_models.sample,
    brand_id: random_brand_id,
    price:    sneaker_price,
    sex:      @sneaker_sex.sample,
    image:    upload_fake_image
  )
end

100.times do
  sneaker = create_sneaker
  puts "Sneaker #{sneaker.id} created"
end

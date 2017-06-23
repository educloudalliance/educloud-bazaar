account = Account.where(email: 'carl@bazaar.com').first_or_create! do |item|
  item.name = FFaker::Product.product_name
  item.password = '123456'
end

countries = ['global', 'fi', 'ru']
10.times do |iteration|
  Metadata.where(country: countries.sample).first_or_create! do |item|
    item.country = countries.sample
    item.subject = "/#{FFaker::Lorem.word}/#{FFaker::Lorem.word}"
  end
end

(1..10).each do |iteration|
  Material.where(publisher_resource_id: iteration).first_or_create! do |material|
    language = FFaker::Locale.code
    material.account = account
    material.name = FFaker::Product.product_name
    material.description = FFaker::Lorem.phrase
    material.language = "#{language.downcase}-#{language}"
    material.publisher_resource_id = iteration
    material.publisher_data = 'custom payload'
    material.image = File.open(Rails.root.join('db', 'materials', 'ruby.png').to_s)
    material.tag_list = FFaker::Lorem.words
    material.publisher_url = "#{app.material_url(iteration)}"
    rand(5).times do |meta|
      material.materials_metadata.build(metadata: Metadata.all.sample)
    end
  end
end

Product.destroy_all
License.destroy_all
3.times do
  product = FactoryGirl.create(:product)
  product.materials = Material.all.to_a.sample(3)
  product.save!
end

Product.find_each do |product|
  FactoryGirl.create(:license, expire_on: 1.year.from_now, product: product)
end

Doorkeeper::Application.where(uid: '06E777CD-1DC2-1CDA-6A8E-68B94E413201').first_or_create! do |item|
  item.name = FFaker::Product.product_name
  item.secret = '825d81462ec90220f734af6c6bac5a0e88253d1fa83fb6daecd4f897968bfbdf'
end

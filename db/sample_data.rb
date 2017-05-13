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
    material.name = FFaker::Product.product_name
    material.description = FFaker::Lorem.phrase
    material.language = "#{language.downcase}-#{language}"
    material.publisher_resource_id = iteration
    material.publisher_data = 'custom payload'
    material.image = File.open(Rails.root.join('db', 'materials', 'ruby.png').to_s)
    material.tag_list = FFaker::Lorem.words
    rand(5).times do |meta|
      material.materials_metadata.build(metadata: Metadata.all.sample)
    end
  end
end
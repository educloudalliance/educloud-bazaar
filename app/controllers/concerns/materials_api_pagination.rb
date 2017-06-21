module MaterialsApiPagination
  def pagination_dict(collection)
    hash = { pages: collection.total_pages }
    hash[:next_url] = api_v1_cms_materials_url(page: collection.next_page) if collection.next_page.present?
    hash[:prev_url] = api_v1_cms_materials_url(page: collection.previous_page) if collection.previous_page.present?
    hash
  end
end

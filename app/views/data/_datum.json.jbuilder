json.extract! datum, :id, :name, :content, :type, :created_at, :updated_at
json.url datum_url(datum, format: :json)

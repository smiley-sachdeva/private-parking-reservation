json.extract! feature, :id, :name, :created_at, :updated_at
json.url parking_feature_url(feature.parking,feature, format: :json)

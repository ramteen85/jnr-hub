json.extract! user, :id, :email, :full_name, :phone_no, :location, :password_digest, :website, :about, :created_at, :updated_at
json.url user_url(user, format: :json)

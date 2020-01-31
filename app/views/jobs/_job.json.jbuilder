json.extract! job, :id, :company_name, :location, :description, :salary, :created_at, :updated_at
json.url job_url(job, format: :json)

json.extract! task, :id, :name, :description, :status, :end_date, :date, :created_at, :updated_at
json.url task_url(task, format: :json)

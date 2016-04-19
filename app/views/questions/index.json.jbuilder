json.array!(@questions) do |question|
  json.extract! question, :id, :user_id, :question, :answer
  json.url question_url(question, format: :json)
end

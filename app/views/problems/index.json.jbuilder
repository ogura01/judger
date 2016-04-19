json.array!(@problems) do |problem|
  json.extract! problem, :id, :title, :body
  json.url problem_url(problem, format: :json)
end

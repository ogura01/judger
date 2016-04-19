json.array!(@submissions) do |submission|
  json.extract! submission, :id, :problem_id, :output, :score
  json.url submission_url(submission, format: :json)
end

json.array!(@pieces) do |piece|
  json.extract! piece, :id, :guarantee_start, :guarantee_expiry, :notes, :status
  json.url piece_url(piece, format: :json)
end

class Chirp
  include DataMapper::Resource

  property :id, Serial
  property :text, String, length: 140, required: true
end

DataMapper.finalize
DataMapper.auto_upgrade!

require_relative "photo_uploader"

class Photo
  include DataMapper::Resource

  property :id, Serial

  property :title, String
  validates_presence_of :title,
    :message => "Your photo must have a title."

  property :created_at, DateTime
  validates_presence_of :created_at

  mount_uploader :source, PhotoUploader
  validates_presence_of :source,
    :message => "You didn't choose a file to upload."

  # This saves us from having to set photo.created_at ourselves.
  before :valid?, :set_created_at
  def set_created_at
    self.created_at = Time.now
  end

  # photo.source.url isn't very descriptive - the reader has to know what
  # photo.source is to make any sense of it. photo.original_url makes it
  # easier for any future reader of our code to understand our intention.
  def original_url
    self.source.url
  end

  # When we want to embed an image, this allows us to call "photo.thumb_url"
  # instead of the more verbose and typo-prone "photo.source.thumb.url".
  def thumb_url
    self.source.thumb.url
  end

  # Same as Photo#thumb_url, but for the full-sized version.
  def full_url
    self.source.full.url
  end
end

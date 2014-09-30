require "./environment"

before do
  puts "  --- Params: #{params.inspect}"
end

helpers do
  # e.g., time_with_zone(photo.created_at, "America/Los_Angeles")
  def time_with_zone(time, zone_label)
    zone = TZInfo::Timezone.get(zone_label)
    offset = zone.period_for_utc(time).utc_offset

    time + offset
  end

  # e.g., format_time(photo.created_at). Returns times that look like
  #   "September 30, 2014 at 5:32PM"
  def format_time(time)
    time.strftime("%B %d, %Y at %l:%M%p")
  end

  def format_time_with_zone(time, zone_label)
    format_time(time_with_zone(time, zone_label))
  end
end

get("/") do
  photos = Photo.all
  erb(:index, :locals => { :photos => photos })
end

get("/photos/new") do
  photo = Photo.new
  erb(:photos_new, :locals => { :photo => photo })
end

get("/photos/*") do |photo_id|
  photo = Photo.get(photo_id)
  erb(:photos_show, :locals => { :photo => photo })
end

post("/photos") do
  photo = Photo.create(params[:photo])

  if photo.saved?
    redirect("/")
  else
    erb(:photos_new, :locals => { :photo => photo })
  end
end

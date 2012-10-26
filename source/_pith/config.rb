project.helpers do

	def published_note
		time_now = Time.now()
		"Published on #{time_now.strftime("%d %B %Y")}"
	end

end

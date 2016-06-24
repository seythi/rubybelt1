class Song < ActiveRecord::Base
	validates :title, :artist, presence: true, length: {minimum: 2}
	has_many :playlists
	has_many :listusers, through: :playlists, source: :user
	def increment
		return self.playcount + 1
	end
	def header
		return artist + " - " + title
	end
end

class User < ActiveRecord::Base
	has_secure_password
	validates :firstname, :lastname, :email, presence: true, length: {minimum: 2}
    validates :email, uniqueness: {case_sensitive: false}
    validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
	has_many :playlists
	has_many :listsongs, through: :playlists, source: :song

	def fullname
		return self.firstname + " " + self.lastname
	end
end

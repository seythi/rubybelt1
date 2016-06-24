class Playlist < ActiveRecord::Base
  validates :song, uniqueness: {scope: :user}
  belongs_to :user
  belongs_to :song
  def increment
  	return self.count + 1
  end
end

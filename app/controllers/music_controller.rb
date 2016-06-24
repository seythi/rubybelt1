class MusicController < ApplicationController
  before_action :reqlogin, except: [:main, :dologin, :doregister]
  def main

  end

  def songs
  	@cuser = User.find(session[:id])
  	@songs = Song.order('id DESC').all
  end

  def dologin
    targ = User.find_by email: params[:email]
    if targ.authenticate(params[:password])
      session[:id] = targ.id
      redirect_to songs_path
    else
      flash[:errors] = 'Invalid email/password combination'
      redirect_to "/"
    end
  end

  def doregister
    nu = User.new(user_params)
    if nu.save
      session[:id] = User.last.id
      redirect_to songs_path
    else
      flash[:errors] = nu.errors.messages
      redirect_to "/"
    end
  end

  def dologout
    session.clear
    redirect_to '/'
  end

  def viewsong
  	@song = Song.find(params[:id])
  	render template: 'music/showsong'
  end

  def userlist
  	@user = User.find(params[:id])
  	render template: 'music/playlist'
  end

  def newsong
  	ns = Song.new(song_params)
  	if ns.save
  		redirect_to songs_path
  	else
  		flash[:errors] = nu.errors.messages
  	end
  	redirect_to songs_path
  end

  def addtolist
  	song = Song.find(params[:id])
  	user = User.find(session[:id])
  	playlist = Playlist.new(song:song, user:user, count: 1)
  	unless playlist.save
  		pl = Playlist.where(song:song).find_by(user:user)
  		pl.update(count:pl.increment)
  	end
  	song.update(playcount:song.increment)
  	redirect_to songs_path
  	
  end

  private

	  def user_params
	    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
	  end
	  
	  def song_params
	  	params.require(:song).permit(:title, :artist).merge(playcount: 0)
	  end
	  def reqlogin
	  	unless session[:id]
	  		flash[:errors] = 'you must be logged in'
	  		redirect_to '/'
	  	end
	  end
  
end

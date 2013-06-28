class HomeController < ApplicationController
	before_filter :require_valid_user
	def show
	end
end
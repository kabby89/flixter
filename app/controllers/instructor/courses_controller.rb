class Instructor::CoursesController < ApplicationController
before_action :authenticate_user!
before_action :require_authentication_for_course_user, :only => [:show]

	def new
		@course = Course.new
	end

	def create
		@course = current_user.courses.create(course_params)
		redirect_to instructor_course_path(@course)
	end

	def show
		@section = Section.new
	end

	private
	def require_authentication_for_course_user
		if current_course.user != current_user
			return render :text => 'Unauthorized', :status => :unauthorized
		end
	end

	helper_method :current_course
	def current_course
		@current_course ||= Course.find(params[:id])
	end

	def course_params
		params.require(:course).permit(:title, :description, :cost, :image)
	end
end

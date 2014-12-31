class Instructor::SectionsController < ApplicationController
before_action :authenticate_user!
before_action :require_authentication_for_course_user

	def new
		@section = Section.new
	end

	def create
		@section = current_course.sections.create(section_params)
		redirect_to instructor_course_path(current_course)
	end

	private
	def require_authentication_for_course_user
		if current_course.user != current_user
			return render :text => 'Unauthorized', :status => :unauthorized
		end
	end

	helper_method :current_course
	def current_course
		@current_course ||= Course.find(params[:course_id])
	end
	def section_params
		params.require(:section).permit(:title)
	end
end

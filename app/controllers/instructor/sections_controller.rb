class Instructor::SectionsController < ApplicationController
before_action :authenticate_user!
before_action :require_authentication_for_course_user, :only => [:new, :create]
# before_action :require_authentication_for_section_reorder, :only => [:update]

	def new
		@section = Section.new
	end

	def create
		@section = current_course.sections.create(section_params)
		redirect_to instructor_course_path(current_course)
	end

	def update
		current_section.update_attributes(section_params)
		render :text => "Updated!"
	end

	private
	# def require_authentication_for_section_reorder
	#	if current_section.user != current_user
	#		return render :text => 'Unauthorized', :status => :unauthorized
	#	end
	# end

	def require_authentication_for_course_user
		if current_course.user != current_user
			return render :text => 'Unauthorized', :status => :unauthorized
		end
	end

	def current_section
		@current_section ||= Section.find(params[:id])
	end

	helper_method :current_course
	def current_course
		@current_course ||= Course.find(params[:course_id])
	end
	def section_params
		params.require(:section).permit(:title, :row_order_position)
	end
end

module Api
  module V1
    class StudentsController < ApplicationController

      before_action :fetch_klass_section

      before_action :fetch_student, only: [:show, :update, :destroy]


      def index
        @students = @section.students
      end

      def show
      end

      def create
        @student = @section.students.new(student_params)

        if @student.save
          head :created, location: api_v1_klass_section_students_url(@klass, @section)
        else
          head :bad_request
        end
      end

      # def create
      #   @student = @section.students.new
      #   @student = @klass.students.new
      #   @student.roll_number = params[:roll_number]
      #   @student.name = params[:name]
      #   @student.fathers_name = params[:fathers_name]
      #   @student.gender = params[:gender]
      #   @student.email = params[:email]
      #   @student.dob = params[:dob]
      #   @student.phone = params[:phone]
      #   @student.address = params[:address]
      #   @student.house_id = params[:house_id]
      #   @student.section_id = params[:section_id]
      #
      #   if @student.save
      #     head :created, location: api_v1_klass_section_students_url(@klass, @section)
      #   else
      #     head :bad_request
      #   end
      # end

      # def update
      #   if @student.update_attributes(student_params)
      #     head :ok, location: api_v1_klass_section_student_url(@klass, @section,@student)
      #   else
      #     head :bad_request
      #   end
      # end

      # def update
      #   @student.roll_number = params[:roll_number]
      #   @student.name = params[:name]
      #   @student.fathers_name = params[:fathers_name]
      #   @student.gender = params[:gender]
      #   @student.email = params[:email]
      #   @student.dob = params[:dob]
      #   @student.phone = params[:phone]
      #   @student.address = params[:address]
      #   @student.house_id = params[:house_id]
      #   @student.section_id = params[:section_id]
      #
      #   if @student.save
      #     head :created, location: api_v1_klass_section_students_url(@klass, @section)
      #   else
      #     head :bad_request
      #   end
      # end




      def update
        @student.name = params[:name] || @student.name
        @student.roll_number = params[:roll_number] || @student.roll_number
        @student.fathers_name = params[:fathers_name] || @student.fathers_name
        @student.gender = params[:gender] || @student.gender
        @student.email = params[:email] || @student.email
        @student.dob = params[:dob] || @student.dob
        @student.phone = params[:phone] || @student.phone
        @student.address = params[:address] || @student.address
        @student.house_id = params[:house_id] || @student.house_id
        @student.section_id = params[:section_id] || @student.section_id
        if @student.save
          head :ok, location: api_v1_klass_section_student_url(@klass, @section, @student)
        else
          head :bad_request
        end
      end

      def destroy
        if params[:name] == @student.name
          @student.destroy
          head :ok
        else
          head :bad_request
        end
      end

    private
      def fetch_klass_section
        @klass = Klass.find(params[:klass_id])
        @section = @klass.sections.find(params[:section_id])
      end

      def fetch_student
        @student = @section.students.find(params[:id])
      end

      def student_params
        params.require(:student).permit(:name, :roll_number, :fathers_name, :gender, :email, :address, :phone, :dob, :house_id)
      end
    end
  end
end

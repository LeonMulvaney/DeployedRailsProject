class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
      @q = Appointment.all.ransack(params[:q])
      @appointments = @q.result(distinct: true).paginate(:per_page => 5, :page => params[:page])
      @searchresult =  @q.result(distinct: true)#Create instance variable to send via prawn.new() method

      #Use the Prawn gem to produce a Patients Report
      #From: http://railscasts.com/episodes/153-pdfs-with-prawn-revised?autoplay=true
      respond_to do |format| #Loop when request is made
        format.html
        format.pdf do #Set up the PDF
          pdf = AppointmentPdf.new(@searchresult) #Cast @a instance variable as parameter 
          send_data pdf.render, filename: "Patients Report", #Set the PDF Filename
                                type: "application/pdf",
                                disposition: "inline" #Render PDF in browser (Not direct download)
       end
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
    @patients = Patient.all #Instance variable to Allow access to the Patient Model 
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:date, :time, :patient, :visited)
    end
end

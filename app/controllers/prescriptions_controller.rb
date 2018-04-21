class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [:show, :edit, :update, :destroy]

  # GET /prescriptions
  # GET /prescriptions.json
  def index
    @q = Prescription.all.ransack(params[:q])
    @prescriptions = @q.result(distinct: true).paginate(:per_page => 5, :page => params[:page])
  end

  # GET /prescriptions/1
  # GET /prescriptions/1.json
def show
  @prescription = Prescription.find(params[:id])
  @name = @prescription.patient_name #Get name to search for below
  @patient = Patient.find_by_name(@name)# Get the patient model by name instead of id From: https://stackoverflow.com/questions/5572266/rails-3-find-by-name-instead-of-id
  @user_name = "#{current_user.first_name} #{current_user.last_name}" #Get current user details
  @user_clinic = current_user.clinic
  @user_email = current_user.email


  respond_to do |format|
    format.html
    format.pdf do
      pdf = PrescriptionPdf.new(@prescription,@patient, @user_name, @user_clinic, @user_email) #Pass parameters to Custom PDF Class
      send_data pdf.render, filename: "Medical Prescription",
                            type: "application/pdf",
                            disposition: "inline"
                            
    end
  end
end

  # GET /prescriptions/new
  def new
    @prescription = Prescription.new
    @patients = Patient.all #Instance variable to Allow access to the Patient Model 
  end

  # GET /prescriptions/1/edit
  def edit
  end

  # POST /prescriptions
  # POST /prescriptions.json
  def create
    @prescription = Prescription.new(prescription_params)
    @result = Autoappointment.generate(@prescription) #Pass new prescription to Gem and save result as variable

    if @result == "True" #Check result from Gem, act accordingly
      respond_to do |format|
        if @prescription.save
          format.html { redirect_to @prescription, notice: 'Prescription was successfully created. Follow up appointment scheduled.' }
          format.json { render :show, status: :created, location: @prescription }

        else
          format.html { render :new }
          format.json { render json: @prescription.errors, status: :unprocessable_entity }
        end
    end

    else
      respond_to do |format|
        if @prescription.save
          format.html { redirect_to @prescription, notice: 'Prescription was successfully created.' }
          format.json { render :show, status: :created, location: @prescription }

        else
          format.html { render :new }
          format.json { render json: @prescription.errors, status: :unprocessable_entity }
        end
      end
    end

  end #End of Create Method

  # PATCH/PUT /prescriptions/1
  # PATCH/PUT /prescriptions/1.json
  def update
    respond_to do |format|
      if @prescription.update(prescription_params)
        format.html { redirect_to @prescription, notice: 'Prescription was successfully updated.' }
        format.json { render :show, status: :ok, location: @prescription }
      else
        format.html { render :edit }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prescriptions/1
  # DELETE /prescriptions/1.json
  def destroy
    @prescription.destroy
    respond_to do |format|
      format.html { redirect_to prescriptions_url, notice: 'Prescription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prescription_params
      params.require(:prescription).permit(:date, :patient_name, :medication_name, :strength, :frequency, :duration, :special_instructions, :follow_up)
    end
end

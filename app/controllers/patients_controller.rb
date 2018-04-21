class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  # GET /patients.json
  def index
      @q = Patient.all.ransack(params[:q])
      @patients = @q.result(distinct: true).paginate(:per_page => 5, :page => params[:page])
      @searchresult = @q.result(distinct: true)

        respond_to do |format| #Loop when request is made
        format.html
        format.pdf do #Set up the PDF
          pdf = PatientPdf.new(@searchresult) #Cast @searchresult instance variable as parameter 
          send_data pdf.render, filename: "Patients Report", #Set the PDF Filename
                                type: "application/pdf",
                                disposition: "inline" #Render PDF in browser (Not direct download)
       end
    end

  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

def import
  Patient.import(params[:file]) #Pass file through file parameter
  redirect_to patients_path, notice: "Patients Successfully imported." #Notify user of successful import
end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    #Permit new attributes after migration From: https://stackoverflow.com/questions/21806545/new-columns-not-saving-in-rails-form-for
    def patient_params
      params.require(:patient).permit(:name, :dob, :address, :phone, :allergy_condition)
    end


end

class HospitalReferralsController < ApplicationController
  before_action :set_hospital_referral, only: [:show, :edit, :update, :destroy]

  # GET /hospital_referrals
  # GET /hospital_referrals.json
  def index
      @q = HospitalReferral.all.ransack(params[:q])
      @hospital_referrals = @q.result(distinct: true).paginate(:per_page => 5, :page => params[:page])
      @searchresult =  @q.result(distinct: true)#Create instance variable to send via prawn.new() method
      @user_name = "#{current_user.first_name} #{current_user.last_name}" #Combine First and Last Names
      @user_clinic = current_user.clinic
      @user_email = current_user.email


  #PDF Method in both index and Show so can be accessed in either location
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReferralPdf.new(@hospital_referral,@patient, @user_name)
        send_data pdf.render, filename: "Hospital Referral",
                              type: "application/pdf",
                              disposition: "inline"
                              
      end
    end
  end

  # GET /hospital_referrals/1
  # GET /hospital_referrals/1.json
def show
  @hospital_referral = HospitalReferral.find(params[:id])
  @name = @hospital_referral.patient_name #Get name to search for below
  @patient = Patient.find_by_name(@name)# Get the patient model by name instead of id From: https://stackoverflow.com/questions/5572266/rails-3-find-by-name-instead-of-id
  @user_name = "#{current_user.first_name} #{current_user.last_name}" #Get current user details
  @user_clinic = current_user.clinic
  @user_email = current_user.email
  @patientdob = Date.parse(@patient.dob).strftime("%Y").to_i
  @ward = Whichward.check((Time.current.year)-@patientdob)


  respond_to do |format|
    format.html
    format.pdf do
      pdf = ReferralPdf.new(@hospital_referral,@patient, @user_name, @user_clinic, @user_email, @ward)
      send_data pdf.render, filename: "Hospital Referral",
                            type: "application/pdf",
                            disposition: "inline"
                            
    end
  end
end

  # GET /hospital_referrals/new
  def new
    @hospital_referral = HospitalReferral.new
    @patients = Patient.all #Instance variable to Allow access to the Patient Model 
  end

  # GET /hospital_referrals/1/edit
  def edit
  end

  # POST /hospital_referrals
  # POST /hospital_referrals.json
  def create
    @hospital_referral = HospitalReferral.new(hospital_referral_params)

    respond_to do |format|
      if @hospital_referral.save
        format.html { redirect_to @hospital_referral, notice: 'Hospital referral was successfully created.' }
        format.json { render :show, status: :created, location: @hospital_referral }
      else
        format.html { render :new }
        format.json { render json: @hospital_referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hospital_referrals/1
  # PATCH/PUT /hospital_referrals/1.json
  def update
    respond_to do |format|
      if @hospital_referral.update(hospital_referral_params)
        format.html { redirect_to @hospital_referral, notice: 'Hospital referral was successfully updated.' }
        format.json { render :show, status: :ok, location: @hospital_referral }
      else
        format.html { render :edit }
        format.json { render json: @hospital_referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hospital_referrals/1
  # DELETE /hospital_referrals/1.json
  def destroy
    @hospital_referral.destroy
    respond_to do |format|
      format.html { redirect_to hospital_referrals_url, notice: 'Hospital referral was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hospital_referral
      @hospital_referral = HospitalReferral.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hospital_referral_params
      params.require(:hospital_referral).permit(:date, :patient_name, :hospital_name, :referral_reason, :department)
    end
end

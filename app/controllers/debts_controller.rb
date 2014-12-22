class DebtsController < ApplicationController
  before_action :set_user
	before_action :set_debt, only: [:edit, :update, :destroy]


  def new
   if is_authorized?
    @debt = @user.debts.new  
   else
    flash[:notice] = "Nice try.  You can't create debts for other users."
    redirect_to user_path(@user)    
   end

  end

  def edit
    unless is_authorized?
      flash[:notice] = "Nice try.  You can't create debts for other users."
      redirect_to user_path(@user)
    end
  end	

  def create
  	@debt = @user.debts.build(debt_params)

    if is_authorized?
  	 if @debt.save
  		  redirect_to user_path(@user)
  	 else
  		  render :new
  	 end
    else
      flash[:notice] = "Nice try.  You can't create debts for other users."
      render :new
    end  
  end


  def update
  	if is_authorized?
     if @debt.update(debt_params)
  		redirect_to user_path(@user)
  	 else
  		  render :edit
  	 end
    end
  end

  def destroy
    if is_authorized?    
  	 @debt.destroy
  	 redirect_to user_path(@user) 
    else
      flash[:notice] = "Nice try.  You can't create debts for other users."
      redirect_to user_path(@user)     
    end
  end

  def complete
    if is_authorized?
      debts = Debt.find(params[:debt_ids])
      debts.each { |debt| debt.destroy }
      redirect_to user_path(@user)
    # else
    #   flash[:notice] = "Nice try.  You can't create debts for other users."
    #   redirect_to user_path(@user)    
    end

  end

  private

    def is_authorized?
      @user == current_user
    end
      
    def set_user
      @user = User.find(params[:user_id])
    end

  	def set_debt
  		@debt = Debt.find(params[:id])
  	end

  	def debt_params
  		params.require(:debt).permit(:description, :category, :is_fulfilled, :user_id, :lender)
  	end
end

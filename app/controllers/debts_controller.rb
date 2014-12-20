class DebtsController < ApplicationController
  before_action :set_user
	before_action :set_debt, only: [:edit, :update, :destroy]

  def new
  	@debt = @user.debts.new
  end

  def edit
  end	

  def create
  	@debt = @user.debts.build(debt_params)

  	if @debt.save
  		redirect_to user_path(@user)
  	else
  		render :new
  	end
  end

  def update
  	if @debt.update(debt_params)
  		redirect_to user_path(@user)
  	else
  		render :edit
  	end
  end

  def destroy
  	@debt.destroy
  	redirect_to user_path(@user)
  end

  def complete
    debts = Debt.find(params[:debt_ids])
    debts.each { |debt| debt.destroy }
    redirect_to user_path(@user)
  end

  private

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

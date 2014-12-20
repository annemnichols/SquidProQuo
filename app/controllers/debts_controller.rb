class DebtsController < ApplicationController
  before_action :set_user
	before_action :set_debt, only: [:edit, :update, :destroy]

  def new
  	@debt = Debt.new
  end

  def edit
  end	

  def create
  	@debt = Debt.new(debt_params)

  	if @debt.save
  		redirect_to root_path
  	else
  		render :new
  	end
  end

  def update
  	if @debt.update(debt_params)
  		redirect_to root_path
  	else
  		render :edit
  	end
  end

  def destroy
  	@debt.destroy
  	redirect_to root_path
  end


  private

    def set_user
      @user = User.find(params[:user_id])
    end

  	def set_debt
  		@debt = Debt.find(params[:id])
  	end

  	def debt_params
  		params.require(:debt).permit(:description, :category, :is_fulfilled, :user_id)
  	end
end

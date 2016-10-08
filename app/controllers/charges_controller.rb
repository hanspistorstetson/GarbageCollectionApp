class ChargesController < ApplicationController

  before_action :amount_to_be_charged
  before_action :set_description
  before_action :logged_in?

  def new
  end

  def thanks
  end


  def create
    # Amount in cents
    @amount = 250

    customer = StripeTool.create_customer(
                                          email: params[:stripeEmail],
                                          stripe_token: params[:stripeToken]
                                          )

    charge = StripeTool.create_charge(
                                      customer_id: customer.id,
                                      amount: @amount,
                                      description: @description
                                      )
    
    redirect_to thanks_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  private

    def amount_to_be_charged
      @amount = 250
    end

    def set_description
      @description = 'Stetson Garbage Service'
    end





end

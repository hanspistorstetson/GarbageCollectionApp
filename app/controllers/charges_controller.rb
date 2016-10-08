class ChargesController < ApplicationController

  before_action :set_plan

  def new
  end

  def create
    # Amount in cents
    @amount = 250

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    if params[:subscription].include? 'yes'
      StripeTool.create_membership(
        email: params[:stripeEmail],
        stripeToken: params[:stripeToken],
        plan: @plan
        )
    else
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Stetson Garbage Collection',
        :currency    => 'usd'
      )
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end



  private

    def set_plan
      @plan = 'weekly_garbage'
    end








end

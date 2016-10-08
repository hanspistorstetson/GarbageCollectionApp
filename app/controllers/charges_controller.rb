class ChargesController < ApplicationController

def new
end

def create
  # Amount in cents
  @amount = 250

  customer = StripeTool.create_customer(
                                        email: params[:stripeEmail]
                                        stripe_token: params[:stripe_token]
                                        )

  charge = StripeTool.create_charge(
                                    customer_id: customer_id,
                                    amount: @amount,
                                    description: 'Stetson Garbage Service'
                                    )
  

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end





end

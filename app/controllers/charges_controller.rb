class ChargesController < ApplicationController
  def new
  end

  def create
    token = params[:stripeToken]
      

    charge = StripeWrapper::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    if (charge.successful?)
      flash[:sucess] = "Thank you for your generous support."
      redirect_to new_charge_path
    else
      flash[:error] = charge.error_message
      redirect_to new_charge_path
    end
  end
end

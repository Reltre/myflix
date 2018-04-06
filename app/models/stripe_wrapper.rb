module StripeWrapper
  class Charge
    def self.create(options={})
      Stripe::Charge.create(amount: options[:amount],
                            currency: 'usd',
                            card: options[:carad])
    end
  end

  def self.set_api_key
    Stripe.api_key = if Rails.env.production?
                       Rails.configuration.stripe[:secret_live_key]
                     else 
                       Rails.configuration.stripe[:secret_test_key]
                     end
  end
end
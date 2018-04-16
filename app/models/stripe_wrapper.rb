module StripeWrapper
  class Charge
    attr_reader :response, :status
    def initialize(response, status)
      @response = response
      @status = status
    end

    def self.create(options={})
      begin
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: 'usd',
          customer: options[:customer],
          description: options[:description],
          card: options[:card]
        )
        new(response, :success)
      rescue Stripe::CardError => e
        new(e, :error)
      end 
    end

    def successful?
      status == :success
    end

    def amount
      @response[:amount]
    end

    def currency
      @response[:currency]
    end
  
    def error_message
      response.message
    end
  
    def self.set_api_key
      Stripe.api_key = if Rails.env.production?
                         Rails.configuration.stripe[:secret_live_key]
                       else 
                         Rails.configuration.stripe[:secret_test_key]
                       end
    end
  end
end
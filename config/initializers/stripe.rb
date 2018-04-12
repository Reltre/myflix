if Rails.env.production?
  Rails.configuration.stripe = {
    :publishable_key => ENV['PUBLISHABLE_KEY'],
    :secret_key => ENV['SECRET_KEY']
  }
else
  Rails.configuration.stripe = { 
    :publishable_key => 'pk_test_61yMW8BG4x48Bp4qLMaxPEMA',
    :secret_key => 'sk_test_5qoCenpxXameFtfQuUF214Zw'
  }
end


Stripe.api_key = Rails.configuration.stripe[:secret_key]

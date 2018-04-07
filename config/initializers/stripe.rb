Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_test_key => 'sk_test_5qoCenpxXameFtfQuUF214Zw',
  :secret_live_key => ENV['SECRET_KEY'] # Current set to test key since app isn't live
}

Stripe.api_key = Rails.configuration.stripe[:secret_test_key]

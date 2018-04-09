require "rails_helper"

describe StripeWrapper do 
  describe StripeWrapper::Charge, :vcr do
    describe ".create" do
      before do
        StripeWrapper::Charge.set_api_key
      end

      let(:token) do
        token = Stripe::Token.create(
          :card => {
            :number => card_number,
            :exp_month => 4,
            :exp_year => 2019,
            :cvc => "314"
          }
        ).id
      end



      context "with valid credit card" do
        let(:card_number) { '4242424242424242' }

        it "charges the card successfully" do
          response = StripeWrapper::Charge.create(amount: 999, card: token)
          expect(response.successful?).to eq(true) 
          expect(response.amount).to eq(999)
          expect(response.currency).to eq('usd')
        end
      end

      context "with invalid credit card" do
        let(:card_number) { '4000000000000002' }
        let(:response) { StripeWrapper::Charge.create(amount: 300, card: token) }
        it "doesn't charge the card successfully" do
          expect(response.successful?).to eq(false)
        end

        it "contains an error message" do
          expect(response.error_message).to eq('Your card was declined.')
        end
      end
    end
  end
end
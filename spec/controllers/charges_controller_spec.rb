require 'rails_helper'

describe ChargesController do
  describe "POST create" do
    let(:charge_instance) { instance_double(StripeWrapper::Charge) }
    let(:charge_class) { class_double(StripeWrapper::Charge).as_stubbed_const(:transfer_nested_constants => true) }
    context "with successful charge" do
      before do
        allow(charge_instance).to receive_messages(:successful? => true)
        allow(charge_class).to receive_messages(:create => charge_instance)
        post :create, params: { token: '123' }
      end
      
      it "sets the success flash message" do
        expect(flash[:success]).to eq('Thank you for your generous support!')
      end

      it "redirects to the new charge path" do
        expect(response).to redirect_to(new_charge_path)
      end
    end

    context "with unsuccessful chage" do
      before do
        allow(charge_instance).to receive_messages(:successful? => false,  :error_message => 'Your card was declined.')
        allow(charge_class).to receive_messages(:create => charge_instance)
        post :create, params: { token: '123' }
      end

      it "sets the flash error message" do
        expect(flash[:error]).to eq('Your card was declined.')
      end

      it "redirects to the new charge path" do
        expect(response).to redirect_to(new_charge_path)
      end
    end
  end
end
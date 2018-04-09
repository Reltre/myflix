require 'rails_helper'

describe ChargesController do
  describe "POST create" do
    context "with successful charge" do
      it "sets the success flash message" do
        charge_instance = instance_double(StripeWrapper::Charge)
        charge_class = class_double(StripeWrapper::Charge).as_stubbed_const(:transfer_nested_constants => true)
        allow(charge_instance).to receive_messages(:successful? => true)
        allow(charge_class).to receive_messages(:create => charge_instance)
        post :create, params: { token: '123' }

        expect(flash[:success]).to eq('Thank you for your generous support!')
      end
      it "redirects to the new payment path"
    end
    context "with unsuccessful chage" do
      it "sets the flash error message"
      it "redirects to the new payment path"
    end
  end
end
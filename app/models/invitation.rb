class Invitation < ActiveRecord::Base
  include Tokenable

  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

  validates_presence_of :email, :token
end

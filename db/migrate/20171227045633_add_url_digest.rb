class AddUrlDigest < ActiveRecord::Migration[5.1]
  def change
    add_column(:users, :url_digest, :string)
    add_column(:videos, :url_digest, :string)
  end
end

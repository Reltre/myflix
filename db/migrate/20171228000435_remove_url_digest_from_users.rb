class RemoveUrlDigestFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column(:users, :url_digest)
  end
end

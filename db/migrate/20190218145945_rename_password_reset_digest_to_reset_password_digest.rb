class RenamePasswordResetDigestToResetPasswordDigest < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.rename :password_reset_digest, :reset_password_digest
      t.rename :password_reset_sent_at, :reset_password_sent_at
    end
  end
end

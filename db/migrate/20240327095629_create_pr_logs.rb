class CreatePrLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :pr_logs do |t|
      t.string :title
      t.string :state
      t.datetime :merged_at
      t.datetime :created_time
      t.string :pr_username
      t.string :user_avatar
      t.string :user_profile_link
      t.string :merged_by
      t.string :merged_user_avatar

      t.timestamps
    end
  end
end

class CreateAvailabilitySlots < ActiveRecord::Migration[8.1]
  def change
    create_table :availability_slots do |t|
      t.references  :user, null: false, foreign_key: true
      t.integer     :day_of_week, null: false # 0 = Sun, 6 = Sat
      t.integer     :hour,        null: false # 0-23
      t.integer     :status,      null: false, default: 0

      t.timestamps
    end

    add_index :availability_slots,
              [:user_id, :day_of_week, :hour],
              unique: true,
              name: "idx_availability_slots_unique_per_user"

    add_check_constraint :availability_slots,
                          "day_of_week BETWEEN 0 AND 6",
                          name: "chk_valid_day_of_week"

    add_check_constraint :availability_slots,
                          "hour BETWEEN 0 AND 23",
                          name: "chk_valid_hour"
  end
end

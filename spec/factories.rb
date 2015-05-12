FactoryGirl.define do
  factory :fleet_commander do
    overall_rating 0
    fun_rating 0
    communication_clarity_rating 0
    noob_friendly_rating 0
    target_selection_rating 0
    friendly_rating 0
  end

  factory :mission_group do
    sequence(:name) {|n| "Group #{n}"}
  end

  factory :user do
    sequence(:main_character_name) {|n| "User #{n}"}
    sequence(:main_character_id) {|n| n}
  end

  factory :member do
    sequence(:characterID) {|n| n}
    sequence(:name) {|n| "Character #{n}"}
    startDateTime DateTime.now
    baseID 0
    base "f"
    title "f"
    logonDateTime nil
    logoffDateTime nil
  end
end

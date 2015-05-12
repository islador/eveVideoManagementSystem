FactoryGirl.define do
  factory :fleet_commander do
    overall_rating ""
    fun_rating ""
    communication_clarity_rating ""
    noob_friendly_rating ""
    target_selection_rating ""
    friendly_rating ""
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

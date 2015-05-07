FactoryGirl.define do
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

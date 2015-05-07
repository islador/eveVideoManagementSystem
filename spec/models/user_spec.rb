# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  sign_in_count       :integer          default("0"), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :inet
#  last_sign_in_ip     :inet
#  created_at          :datetime
#  updated_at          :datetime
#  provider            :string
#  uid                 :string
#  main_character_name :string
#  main_character_id   :integer
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.create(provider: "eve", uid: "1", main_character_name: "User", main_character_id: 1)}

  it "should respond to provider" do
    expect(user.provider).to match "eve"
  end

  describe "less_or_equal_roles" do
  end

  describe "director" do
  end

  describe "member" do
    let(:member) {Member.create()}
  end
end

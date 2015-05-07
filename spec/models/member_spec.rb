# == Schema Information
#
# Table name: members
#
#  id             :integer          not null, primary key
#  characterID    :integer
#  name           :string
#  startDateTime  :datetime
#  baseID         :integer
#  base           :string
#  title          :string
#  logonDateTime  :datetime
#  logoffDateTime :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  taken          :boolean
#  user_id        :integer
#

require 'rails_helper'

RSpec.describe Member, type: :model do
  #let(:member) {Member.create()}
  let(:member) {FactoryGirl.create(:member)}

  it "should have a characterID" do
    expect(member.characterID).to_not be_nil
  end

  it "should have a name" do
    expect(member.name).to_not be_nil
  end

  it "should have a startDateTime" do
    expect(member.startDateTime).to_not be_nil
  end
end

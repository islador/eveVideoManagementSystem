# == Schema Information
#
# Table name: recruit_contacts
#
#  id                :integer          not null, primary key
#  name              :string
#  contacted_by      :string
#  conversation_type :string
#  timezone          :string
#  conclusion        :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class RecruitContact < ActiveRecord::Base
  #contacted_by -> the recruiter who found them
  #conversation_type -> Teamspeak, private convo, public convo
  #timezone -> the recruit's timezone (select option)
  #conclusion -> Text box for the recruiter's opinion of the person.

  validates :name, uniqueness: true
  validates :contacted_by, presence: true
  validates :conversation_type, presence: true
  validates :timezone, presence: true
  validates :conclusion, presence: true
end

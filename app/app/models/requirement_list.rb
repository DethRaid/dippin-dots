# Requirement list is essentially a major, but it can also my a minor or an application domain or a liberal arts
# immersion, so the class is super generic
class RequirementList < ActiveRecord::Base
  has_many :requirements
end

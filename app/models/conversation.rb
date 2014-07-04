class Conversation < ActiveRecord::Base
  has_many :matches
  before_validation :generate_secure_identifier
  validates_presence_of :secure_identifier
  validates_uniqueness_of :secure_identifier

  private
  def generate_secure_identifier
    if !self.secure_identifier
      self.secure_identifier = loop do
        token = SecureRandom.urlsafe_base64
        break token unless Conversation.exists?(secure_identifier: token)
      end
    end
  end
end

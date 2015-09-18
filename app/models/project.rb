# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ActiveRecord::Base
  belongs_to :user

  has_many :project_permissions, dependent: :destroy
  has_many :shared_users, class_name: 'User', through: :project_permissions

  has_many :group_permissions, dependent: :destroy

  validates :name, presence: true

  has_many :alerts
  has_many :channel_accesses
  has_many :channels, through: :channel_accesses

  def access_role=(role)
    @access_role = role
    self
  end

  def admin_access_role?
    @access_role != User::PERMISSION_ROLE_NORMAL
  end

  def accessible_channels
    channel_ids = self.channels.map(&:id) + self.user.my_channels.pluck(:id) + self.user.channel_permissions.pluck(:channel_id)
    Channel.where(id: channel_ids)
  end

  def accessible_channel(channel_id)
    channels = self.accessible_channels
    channel = channels.where(id: channel_id)
    return ObjectWithRole.new(channel) if channel

    permission = self.user.channel_permissions.find_by(channel_id: channel_id)
    return ObjectWithRole.new(permission.channel, permission.role) if permission
    raise ActiveRecord::RecordNotFound

  end

  def self.from_query(query)
    like = "#{query}%"
    where([ "name LIKE ?", like ]) 
  end

end

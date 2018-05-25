class Promotion < ActiveRecord::Base
  has_many :photos, :as => :photoable, :dependent => :destroy
  belongs_to :promotionable, :polymorphic => true, :dependent => :destroy
  has_and_belongs_to_many :users

  has_many :registered_members,  :class_name => 'PayablePromotion'

  accepts_nested_attributes_for :photos

  #validates_presence_of :promotionable

  def normal_image
    photos.find(:first, :conditions => " image_type = 'normal'")
  end

  def carousel_image
    photos.find(:first, :conditions => " image_type = 'carousel'")
  end

  def gallery_images
    photos.find(:all, :conditions => " image_type is null")
  end

  def offer_image
    photos.find(:first)
  end

  def active_registered_members
    registered_members.find(:all, :joins => "right join users on users.id = payable_promotions.user_id" )
  end
end

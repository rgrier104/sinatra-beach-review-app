class Beach < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  def slug
    name = self.name.downcase.gsub(' ','-')
  end

  def self.find_by_slug(slug)
    Beach.all.find do |beach|
      beach.slug == slug
    end
  end


end

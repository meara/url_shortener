require 'faker'
require 'uri'

class Url < ActiveRecord::Base
  # Remember to create a migration!
  validate :url_must_be_valid, :on => :create
  validates :short_url, :uniqueness => true
  before_save :generate_short_url
  #assign long url
  #assign short url
  #initialize counter

  def generate_short_url
    new_short = "/" + Faker::Lorem.characters(7)
    until short_url_unique?(new_short)
      new_short = "/" + Faker::Lorem.characters(7)
    end
    self.short_url = new_short
  end

  def short_url_unique?(new_short)
    Url.find_by_short_url(new_short).nil?
  end

  def url_must_be_valid
    unless long_url.match(URI::regexp)
      errors.add(:long_url, 'Url must be valid')
    end
  end

end


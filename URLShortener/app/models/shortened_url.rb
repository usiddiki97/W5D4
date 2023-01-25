# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true
    validates :short_url, presence: true, uniqueness: true
    validates :user_id, presence: true, uniqueness: true

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: 'User'
    
    has_many :visits,
        foreign_key: :shortened_url_id,
        primary_key: :id,
        class_name: 'Visit'

    has_many :visitors,
        through: :visits,
        source: :visitor

    def self.random_code
        loop do
            random_code = SecureRandom.urlsafe_base64
            return random_code unless ShortenedUrl.exists?(short_url: random_code)
        end
    end

    def self.create_short_url(user, long_url)
        ShortenedUrl.create!(
            long_url: long_url,
            short_url: ShortenedUrl.random_code,
            user_id: user.id
        )
    end

    def num_clicks

    end

    def num_uniques

    end

    def num_recent_uniques
        
    end

end

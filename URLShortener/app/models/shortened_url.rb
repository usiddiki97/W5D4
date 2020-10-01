# == Schema Information
#
# Table name: shortened_urls
#
#  id           :bigint           not null, primary key
#  long_url     :string           not null
#  short_url    :string           not null
#  submitter_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true

    belongs_to :submitter,
        foreign_key: :submitter_id,
        primary_key: :id,
        class_name: :User

    has_many :visits,
        foreign_key: :shortened_url_id,
        primary_key: :id,
        class_name: :Visit


    

    def self.random_code
        loop do
            random_code = SecureRandom.urlsafe_base64(16) 
            return random_code unless ShortenedUrl.exists?(short_url: random_code)
        end
    end

    def self.create_short_url(user, long_url)
        ShortenedUrl.create!(
            long_url: long_url,
            short_url: ShortenedUrl.random_code,
            submitter_id: user.id
        )
    end

    def num_clicks

    end

    def num
end

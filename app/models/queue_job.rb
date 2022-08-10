class QueueJob < ApplicationRecord
    extend Enumerize

    validates :title, presence: true, uniqueness: true
    validates :priority, presence: true

    enumerize :status, in: [:waiting, :in_progress, :failed, :done, :blocked, :archived]
    enumerize :priority, in: [:high, :low, :critical, :highest]

    def as_json
        super()
    end

end

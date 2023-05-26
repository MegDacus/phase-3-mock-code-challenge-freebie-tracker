class Dev < ActiveRecord::Base
    has_many :freebies
    has_many :companies, through: :freebies

    def freebies
        Freebie.where(dev_id: self.id)
    end

    def companies
        self.freebies.map do |freebie|
            Company.find(freebie.company_id)
        end
    end

    def received_one?(item_name)
        if self.freebies.exists?
            self.freebies.exists?(item_name: item_name)
        else
            false
        end
    end

    def give_away(dev, freebie)
        if self.received_one?(freebie.item_name)
            freebie.update(dev_id: dev.id)
            "You've given your #{freebie.item_name} to #{dev.name}"
        else
            "You can't give away a freebie you don't have!"
        end
    end
end



class Company < ActiveRecord::Base
 has_many :freebies
 has_many :devs, through: :freebies

   def freebies
      Freebie.where(company_id: self.id)
   end

   def devs
      freebies.map do |freebie|
         Dev.find(freebie.dev_id)
      end
   end

   def give_freebie(dev, item_name, value)
      Freebie.create(item_name: item_name, value: value, company_id: self.id, dev_id: dev.id)
   end

   def self.oldest_company
      Company.order(:founding_year).limit(1)
   end
end

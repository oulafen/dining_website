class MerchantLabel < ActiveRecord::Base
  attr_accessible :user_id, :label_id

  def self.get_merchant_labels(id)
    m_ls = MerchantLabel.where(:user_id => id)
    merchant_labels=[]
    m_ls.each do |m_l|
      m ={}
      m["label_id"] = m_l.label_id
      m["category"] = Label.find_by(id: m_l.label_id).category
      m["content"] = Label.find_by(id:m_l.label_id).content.gsub(" ","&nbsp;")
      merchant_labels.push(m)
    end
    merchant_labels
  end

end
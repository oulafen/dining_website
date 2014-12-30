class Merchant < ActiveRecord::Base
  has_secure_password
  validates :user_name , :presence => true, :uniqueness => {:case_sensitive => false}
  validates :restaurant_name , :presence => true

  attr_accessible :user_name, :restaurant_name, :password, :password_confirmation, :login_type, :addr, :phone, :logo, :remark,:email,:status,:private_cuisine,:outer_sell,:time_from,:time_to

  has_attached_file :logo, :styles => { :small => "30x30>" },
                    :url  => "/assets/merchants/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/merchants/:id/:style/:basename.:extension"
  #validates_attachment_presence :href
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png','image/gif']


  def self.judge_login_input(user)
    merchant = Merchant.find_by(user_name: user[:user_name])
    is_legal = merchant && merchant.authenticate(user[:password])
    is_legal ? merchant : false
  end

  def self.get_merchant_detail(label_content)
    merchants=[]
    label = Label.where("content like ?", "%#{label_content}%") #找到卤味label记录
    if label.empty?
      return merchants
    end
    merchant_ids = MerchantLabel.where(:label_id => label[0].id) #找到所有卤味标签的记录
    merchant_ids.each do |id|
      temp_merchant = {}
      merchant=Merchant.find_by(id: id.user_id)  #一个有卤味标签的商家
      temp_merchant["id"] = merchant.id
      temp_merchant["user_name"] = merchant.user_name
      temp_merchant["restaurant_name"] = merchant.restaurant_name
      temp_merchant["addr"] = merchant.addr
      temp_merchant["phone"] = merchant.phone
      temp_merchant["logo"] = merchant.logo
      temp_merchant["private_cuisine"] = merchant.private_cuisine
      temp_merchant["outer_sell"] = merchant.outer_sell
      temp_merchant["favor_num"] = merchant.favor_num
      merchants.push(temp_merchant)
    end
    merchants #所有卤味标签的商家
  end

  def self.get_merchants(label_content)
    merchants=[]
    label = Label.where("content like ?", "%#{label_content}%")
    if label.empty?
      return merchants
    end
    merchant_ids = MerchantLabel.where(:label_id => label[0].id)

    merchant_ids.each do |id|
      temp_merchant = {}
      merchant=Merchant.find_by(id:id.user_id)

      temp_merchant["id"] = merchant.id
      temp_merchant["user_name"] = merchant.user_name
      temp_merchant["restaurant_name"] = merchant.restaurant_name
      temp_merchant["dish"] = []
      dishes = Dish.where(:user_id => merchant.id)
      dishes.each do |dish|
        temp_dish = {}
        temp_dish["dish_name"] = dish.name
        temp_merchant["dish"].push(temp_dish)
      end
      merchants.push(temp_merchant)
    end
    merchants
  end

  def self.update_merchant_info(params,merchant,addrs,user_id)
    if params[:merchant][:href]
       merchant[:href]= params[:merchant][:href]
    end

    if params[:time_from]
      merchant[:time_from]= params[:time_from]
    end
    if params[:time_to]
      merchant[:time_to]= params[:time_to]
    end

    merchant.update_attributes(params[:merchant])
    for i in 0...addrs.length
      addr = Addr.find_by(id: addrs[i].id)
      addr.update_attributes({:address => params[:"addr_address#{addrs[i].id}"], :phone => params[:"addr_phone#{addrs[i].id}"]})
    end
    if !params[:addr].nil?
      Addr.create({:user_id => user_id, :address => params[:addr][:address], :phone => params[:addr][:phone]})
    end
  end

  def self.get_checked_merchants
    Merchant.all - Merchant.where(:login_type => 'user',:status => "checking")-Merchant.where(:login_type => 'admin')
  end
end

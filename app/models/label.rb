class Label < ActiveRecord::Base
  attr_accessible :content, :category, :category_id,:site,:postcode,:create_type
  validates :content , :presence => true, :uniqueness => {:case_sensitive => false}

  def self.get_labels_by_category_id(category_id)
    labels=Label.where(:category_id=>category_id)
    labels.each do |label|
      label[:content]=label[:content].gsub(' ','&nbsp;')
    end
  end

  def self.get_all_site_labels
    labels = Label.where(:category_id => 1,:create_type => 'admin')
    labels_restaurants=[]
    labels.each do |l|
      label_rest ={}
      label_rest[:label_id] = l.id
      label_rest[:content] = l.content.gsub(" ","")
      label_rest[:site] = l.site
      label_rest[:site_html]=l.site.gsub(" ","&nbsp;")
      label_rest[:short_site_html]=l.site[0,10].gsub(" ","&nbsp;")
      label_rest[:content_html]=l.content.gsub(" ","&nbsp;")
      label_rest[:category] = l.category
      label_rest[:original_content]=l.content
      label_rest[:restaurant_num] = MerchantLabel.where(:label_id => l.id).length
      labels_restaurants.push(label_rest)
    end
    labels_restaurants.sort{ |a,b| a[:restaurant_num] <=>b[:restaurant_num] }.reverse
  end

  def self.get_labels_by_category_id_and_create_type(category_id,create_type)
    labels=Label.where(:category_id => category_id,:create_type => 'admin' ) + Label.where(:category_id => category_id,:create_type => create_type )
    labels.each do |label|
      label[:content]=label[:content].gsub(' ','&nbsp;')
    end
  end

  def self.is_repeated(content,user_name)
    labels=Label.where(:create_type => 'admin')+Label.where(:create_type => user_name)
    labels.each do |label|
      if label[:content].gsub(" ","")==content.gsub(" ","")
        return "true"
      end
    end
  end

  def self.get_site_infos(merchants)
    site_infos=[]
    merchants.each do |merchant|
      merchant_labels=MerchantLabel.where(user_id: merchant["id"])
      merchant_labels.each do |merchant_label|
        if Label.find_by(id:merchant_label[:label_id])[:category_id]==1
          label_content=Label.find_by(id:merchant_label[:label_id])
          if site_infos.find{|site_info|site_info["site"]==label_content["content"]}
            site_infos.map do |site_info|
              if site_info["site"]==label_content["content"]
                site_info["merchant"].push(merchant)
              end
            end
          else
            site_info={"site"=>label_content["content"],"merchant"=>[merchant]}
            site_infos.push(site_info)
          end
        end
      end
    end
    site_infos
  end
end
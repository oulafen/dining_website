class DishLabel < ActiveRecord::Base
  attr_accessible :dish_id, :label_id

  def self.get_dish_labels(dish_id)
    temp_dish_labels = DishLabel.where(:dish_id => dish_id)
    dish_labels = []
    temp_dish_labels.each do |t|
      dish_label = {}
      dish_label["label_id"] = t.label_id
      dish_label["category"] = Label.find_by(id:t.label_id).category
      dish_label["content"] = Label.find_by(id: t.label_id).content.gsub(" ","&nbsp;")
      dish_labels.push(dish_label)
    end
    dish_labels
  end

  def self.get_add_dish_labels(session)
    labels = []
    if session[:add_dish_label_ids]
      session[:add_dish_label_ids].each do |id|
        label = {}
        label["label_id"] = id
        label["category"] = Label.find_by(id: id).category
        label["content"] = Label.find_by(id:id).content
        labels.push(label)
      end
    end
    labels
  end

end
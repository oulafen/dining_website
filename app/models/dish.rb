# coding: utf-8
class Dish < ActiveRecord::Base
  attr_accessible :user_id, :name, :price, :remark, :photo
  has_attached_file :photo, :styles => { :small => "150x150>" },
                    :url  => "/assets/dishes/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/dishes/:id/:style/:basename.:extension"
  #validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']

  def self.get_dishes_by_group(user_id)
    labels_caixi = Label.where(:category => '菜系类')
    dish_labels = []
    labels_caixi.each do |label|
      dish_label = {}
      temp_dishes = []
      dish_ids = DishLabel.where(:label_id => label.id)
      dish_ids.each do |dish|
        find_user_dish = Dish.where(:user_id => user_id, :id => dish.dish_id)
        if !find_user_dish.empty?
          temp_dishes.push(find_user_dish)
        end
      end
      dish_label[:label_content] = label.content
      dish_label[:dish_by_group] = temp_dishes
      dish_labels.push(dish_label)
    end
    dish_labels
  end

  def self.get_dish_names(user_id)
    labels_caixi = Label.where(:category => '菜系类')
    dish_labels = []

    labels_caixi.each do |label|
      dish_label = {}
      temp_dishes = []
      dish_ids = DishLabel.where(:label_id => label.id)
      dish_ids.each do |dish|
        find_user_dish = Dish.where(:user_id => user_id, :id => dish.dish_id)
        if !find_user_dish.empty?
          temp_dishes.push(find_user_dish[0].name)
        end
      end
      dish_label["label_content"] = label.content
      dish_label["dish_names"] = temp_dishes
      dish_labels.push(dish_label)
    end

    dish_labels
  end
end
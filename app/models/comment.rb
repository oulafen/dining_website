class Comment < ActiveRecord::Base
     attr_accessible :merchant_name, :user_name, :comment
     def self.get_comment(merchant_name)
       user_comment= Comment.where(:merchant_name =>merchant_name).reverse;
       user_comment
     end
end
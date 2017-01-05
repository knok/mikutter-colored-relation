# -*- coding: utf-8 -*-

Plugin.create(:colored_relation) do
  UserConfig[:followed_users_background_colod] ||= [45900, 62955, 36776]
  UserConfig[:protected_users_background_color] ||= [0xcccc,0xcccc,0xcccc]

  filter_message_background_color do | mp, array |
    if mp.message.user[:protected] == true
      array = UserConfig[:protected_users_background_color]
    else
      result = Service.any? { |me|
        x = Plugin[:followingcontrol].relation.followers[me.user_obj]
        if ! x.nil? && x && x.any? { |you| you == mp.message.user }
          array = UserConfig[:followed_users_background_color]
        end
      }
    end
    [mp, array]
  end
  
  settings("Users_Relation_Color") do
    color("鍵付きユーザの背景色",:protected_users_background_color)
    color("フォローされているユーザの背景色",:followed_users_background_color)
  end
  
end

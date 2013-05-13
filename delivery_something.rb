#-*- coding: utf-8 -*-

# I've made "@penguin2716's delivery_pizza.rb(https://gist.github.com/penguin2716/4587083)" a reference. Thanks for his code and idea.

Plugin.create :delivery_something do

  register_command = lambda { |command_name_prefix|
    command(:delivery_something,
            name: "#{command_name_prefix}配達しに来い",
            condition: lambda{ |opt| true },
            visible: true,
            role: :timeline) do |opt|
      opt.messages.each { |m|
        Service.primary.post(:message => "@#{m.user.to_s} な〜にが via #{m[:source]} だ早く私の家に#{UserConfig[:delivery_something_delivery]}配達しに来い〄", :replyto => m)
      }
    end
  }

  register_command.call(UserConfig[:delivery_something_delivery])

  on_boot do |service|
	  if UserConfig[:delivery_something_delivery].nil?
		 UserConfig[:delivery_something_delivery] = "ピザ"
	  end
  end

  settings "◯◯配達しに来い" do
    input "配達要求物", :delivery_something_delivery
  end

  UserConfig.connect(:delivery_something_delivery) do |key, new_val, before_val, id|
    register_command.call(new_val)
  end

end


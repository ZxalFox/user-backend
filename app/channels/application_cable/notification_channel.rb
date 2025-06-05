  class NotificationChannel < ActionCable::Channel::Base
    def subscribed
      stream_from "notifications"
      puts "Cliente conectado ao canal de notificações!"
    end
  end

require "redis"

class NotificationListener
  def self.listen
    redis = Redis.new(host: "redis", port: 6379)

    redis.subscribe("notifications") do |on|
      on.message do |channel, message|
        puts "Mensagem recebida no user-backend: #{message}"  # 🔍 Verificar no log
        parsed_message = JSON.parse(message) rescue { type: "error", text: "Formato inválido" }
        ActionCable.server.broadcast("notifications", parsed_message)
      end
    end
  end
end

require_relative 'calcTime'

# react : JSONデータ, WebSocket
def react (data, ws)
    # "hello"に返答
    if data['text'] == "hello"
        ws.send({
            type: "message",
            text: "hello <@#{data['user']}>",
            channel: data['channel']
        }.to_json)
    
    elsif data['type'] == "message" && data['text'] != nil
        msg = data['text'].split("\n")
        
        # "!timekeeper" に反応
        if msg[0] == "!timekeeper"
            time = CalcTime.new(9) #GMT+9:00
            deadline = Time.parse(msg[1]) #時間取得-Time
            task = msg[2] #タスク取得-String
        
            ws.send({
                type: "message",
                text: "#{task}\nまで#{time.calcDays(deadline)}日と#{time.calcHours(deadline)%24}時間です",
                channel: data['channel']
            }.to_json)
        end
    end
end
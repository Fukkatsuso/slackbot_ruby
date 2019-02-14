require "http"
require "json"
require 'eventmachine'
require 'faye/websocket'

# slackAPI = 'APIを入れる'

response = HTTP.post("https://slack.com/api/rtm.start", 
    params: {
        token: slackAPI,
    })
    
rc = JSON.parse(response.body)
url = rc['url']

EM.run do
    # Web Socketインスタンスの立ち上げ
    ws = Faye::WebSocket::Client.new(url)
    
    # 接続が確立したときの処理
    ws.on :open do
        p [:open]
    end
    
    # RTM APIから情報を受け取ったときの処理
    ws.on :message do |event|
        data = JSON.parse(event.data)
        p [:message, data]
        
        # "こんにちは"に反応
        if data['text'] == "こんにちは"
            ws.send({
                type: "message",
                text: "こんにちは <@#{data['user']}> さん",
                channel: data['channel']
            }.to_json)

        # "hello"に反応
        elsif data['text'] == "hello"
            ws.send({
                type: "message",
                text: "hello <@#{data['user']}>",
                channel: data['channel']
            }.to_json)
        end
    end
    
    # 接続が切断したときの処理
    ws.on :close do |event|
        p [:close, event.code]
        ws = nil
        EM.stop
    end
end
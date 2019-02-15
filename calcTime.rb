class CalcTime < Time
    def initialize(td=0)
        @td = td
    end
    
    # 差分時間dif[sec]を計算
    def getDif(time)
        # Time.nowを一旦秒数に変換して時差分を加算
        # ->Timeオブジェクトに変換
        @now = Time.at((Time.now.to_i) + (@td*60*60))
        @dif = time.to_time - @now
    end
    
    # 現在からの残り日数を計算
    def calcDays(time)
        getDif(time)
        (@dif/(60*60*24)).to_i
    end

    # 現在からの残り時間を計算
    def calcHours(time)
        getDif(time)
        (@dif/(60*60)).to_i
    end
end
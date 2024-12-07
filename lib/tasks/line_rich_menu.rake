namespace :line do
    desc "Create LINE Rich Menu"
    task create_rich_menu: :environment do
      require 'line/bot'
  
      # Rails.application.credentials を使用して認証情報を取得
      client = Line::Bot::Client.new do |config|
        config.channel_secret = Rails.application.credentials.dig(:line, :channel_secret)
        config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
      end
  
      # リッチメニューの作成
      response = client.create_rich_menu({
        size: { width: 2500, height: 843 },
        selected: true,
        name: "メニュー名",
        chatBarText: "メニューを開く",
        "areas": [
          {
            "bounds": {
              "x": 0,
              "y": 0,
              "width": 2500,
              "height": 843
            },
            "action": {
              "type": "postback",
              "data": "store_id=1"
            }
          }
        ]
      })
  
      # リッチメニューIDの取得
      if response.code == "200"
        rich_menu_id = JSON.parse(response.body)['richMenuId']
        puts "リッチメニュー作成成功！リッチメニューID: #{rich_menu_id}"
      else
        puts "リッチメニュー作成失敗: #{response.body}"
      end

      # 画像のアップロードを手動リクエストで実行（v3のSDKにファイルアップロードメソッドができていないから）
      uri = URI("https://api-data.line.me/v2/bot/richmenu/#{rich_menu_id}/content")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path)
      request['Authorization'] = "Bearer #{Rails.application.credentials.dig(:line, :channel_token)}"
      request['Content-Type'] = 'image/jpeg'
      request.body = File.read("app/assets/images/sasunatracker.jpg")

    image_response = http.request(request)
    if image_response.code == "200"
      puts "画像アップロード成功"
    else
      puts "画像アップロード失敗: #{image_response.body}"
    end

      # デフォルトリッチメニューの設定
      default_response = client.set_default_rich_menu(rich_menu_id)
      if default_response.code == "200"
        puts "リッチメニューをデフォルトに設定しました"
      else
        puts "デフォルト設定失敗: #{default_response.body}"
      end
    end
  end
  
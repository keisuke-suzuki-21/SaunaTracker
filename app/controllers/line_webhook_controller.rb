class LineWebhookController < ApplicationController
  protect_from_forgery with: :null_session

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']

    # LINEサーバーから送信されたリクエストを検証
    unless client.validate_signature(body, signature)
      head :bad_request
      return
    end

    # JSONリクエストをパース
    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Postback
        # user_idを取得
        user_id = event['source']['userId']
        store_id = extract_store_id(event['postback']['data'])

        # リアルタイム利用者数を取得
        occupancy = get_realtime_occupancy(store_id)

        # LINEプッシュメッセージを送信
        push_message(user_id, store_id, occupancy)
      end
    end

    head :ok
  end

  private

  # LINE Messaging APIクライアント
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_id = Rails.application.credentials.dig(:line, :channel_id)
      config.channel_secret = Rails.application.credentials.dig(:line, :channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
    }
  end

  # store_idを抽出するメソッド
  def extract_store_id(data)
    params = URI.decode_www_form(data).to_h
    params['store_id']
  end

  # リアルタイム利用者数を取得するメソッド
  def get_realtime_occupancy(store_id)
    # 仮のロジック: Storeモデルから利用者数を取得
    store = Store.find_by(id: store_id)
    store ? store.current_occupancy : 0
  end

  # プッシュメッセージを送信するメソッド
  def push_message(user_id, store_id, occupancy)
    store = Store.find(store_id)
    message = {
      type: 'text',
      text: "#{store.name} の現在のサウナ利用者数は #{occupancy} 人です。"
    }

    client.push_message(user_id, message)
  end
end

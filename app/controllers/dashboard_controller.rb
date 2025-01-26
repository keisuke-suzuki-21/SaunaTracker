class DashboardController < ApplicationController
  def index
    @current_users = 42 # サウナのリアルタイム利用者数（例）
    @customer_data = {
      age_groups: { '20代': 30, '30代': 50, '40代以上': 20 },
      visit_frequency: { '週1回': 40, '週2回以上': 60 }
    }
    @messages_status = { sent: 100, clicked: 60 }
    @events = ['キャンペーン開始', '来月のイベント発表']
  end
end

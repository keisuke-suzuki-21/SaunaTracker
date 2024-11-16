# app/services/qr_code_generator.rb
require 'rqrcode'

class QrCodeGenerator
    def self.generate_for_store(store_id)
        base_url = Rails.env.production? ? "https://example.com" : "https://a55e-2400-2410-bf63-6600-517c-8da8-c907-7bf1.ngrok-free.app"

        # entry_url = "#{base_url}/api/v1/transactions/entry?store_id=#{store_id}"
        entry_url = "#{base_url}/entry?store_id=#{store_id}&action=entry"
        exit_url = "#{base_url}/exit?store_id=#{store_id}&action=exit"
        
        save_qr_code(entry_url, "store_#{store_id}_entry.png")
        save_qr_code(exit_url, "store_#{store_id}_exit.png")
      end

  private

  def self.save_qr_code(url, filename)
    qrcode = RQRCode::QRCode.new(url)
    png = qrcode.as_png(size: 300)
    
    # バイナリモードでファイルを開き、書き込む
    File.open(Rails.root.join("public/qr_codes/#{filename}"), "wb") do |file|
      file.write(png.to_s)
    end
  end
end

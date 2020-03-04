module ApiHelper
  def generate_token()
    token_length = 15
    (0...token_length).map { (65 + rand(26)).chr }.join
  end
end

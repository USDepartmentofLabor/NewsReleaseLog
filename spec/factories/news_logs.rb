FactoryBot.define do
  factory :news_log do
    agency "OPA"
    region "NAT"
    title "first news title"
    received_date DateTime.now
  end
end

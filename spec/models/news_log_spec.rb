require 'rails_helper'

RSpec.describe NewsLog, type: :model do
  let(:user) {FactoryBot.build(:user)}
  let(:region) {FactoryBot.create(:region)}

  it { is_expected.to have_field(:title).of_type(String) }
  it { is_expected.to have_field(:opa_id).of_type(Integer) }

  context "NewsLog is created " do
    it "should have opa_id and news_release_number are created in incremental order" do
      news_log = FactoryBot.create(:news_log,user: user, region: region)
      expect(news_log.opa_id).to eq 1
      expect(news_log.news_release_number).to eq "#{Date.current.strftime("%y")}-00001-#{region.code}"
      news_log = FactoryBot.create(:news_log,user: user,region: region)
      expect(news_log.opa_id).to eq 2
      expect(news_log.news_release_number).to eq "#{Date.current.strftime("%y")}-00002-#{region.code}"
    end
  end
end

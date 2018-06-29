class NewsLogPolicy < ApplicationPolicy
  attr_reader :user, :news_log

  def initialize(user, news_log)
    @user = user
    @news_log = news_log
  end

  def update?
    user.admin? or not news_log.published?
  end

  def create?
    user.admin?
  end
end

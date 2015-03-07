class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, counter_cache: true
  validates_presence_of :content

  before_save :cache_content
  after_create :mention_emails

  def cache_content
    context = {
        asset_root: 'https://a248.e.akamai.net/assets.github.com/images/icons/',
        base_url: '/users/'
    }

    pipeline = HTML::Pipeline.new [
                           HTML::Pipeline::MarkdownFilter,
                           HTML::Pipeline::SanitizationFilter,
                           HTML::Pipeline::AutolinkFilter,
                           HTML::Pipeline::EmojiFilter
                        ], context.merge(gfm: true)
    result = pipeline.call(content)

    output = HTML::Pipeline::MentionFilter.mentioned_logins_in(result[:output].to_s) do |mention|
      pre = mention[0] == "@" ? "" : mention.slice!(0)
      mention_user = User.find_for_mention(mention)

      if mention_user
        pre + "<a href=\"/users/#{mention_user.username}\">#{mention}</a>"#link_to(mention, mention_user)
      else
        pre + mention
      end
    end
    self.cached_content = output
  end

  def cache_content!
    cache_content
    save
  end

  def mention_emails
    HTML::Pipeline::MentionFilter.mentioned_logins_in(content) do |mention|
      pre = mention[0] == "@" ? "" : mention.slice!(0)
      mention_user = User.find_for_mention(mention)

      UserMailer.mentioned(mention_user, self).deliver_later if mention_user && mention_user.email_notifications
    end
  end
end

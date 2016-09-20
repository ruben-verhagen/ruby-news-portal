require 'faker'

Author.destroy_all
Post.destroy_all

authors = 12.times.map do
  Author.create(name: Faker::Name.name)
end

32.times do
  p = Post.create(
      post_sections: random_models(PostSection, 3),
      authors: [authors.sample, authors.sample],
      published: random_boolean(0.8),
      published_at: Time.zone.now,
      authors_pick: random_boolean(0.3),
      featured_level: [nil, 1, 2, 3, 4, 5].sample,
      is_breaking_news: random_boolean(0.2),

      countries: [EuroCountry.select_data.sample[-1]],
      cover: (fake_image if random_boolean(0.2)),

      headline: fake_words(12).capitalize,
      byline: fake_sentences(4).capitalize,
      content: fake_paragraphs(20),
      top_lede: random_boolean(0.2),
      in_digest: random_boolean,
      in_ticker: random_boolean
  )
end

10.times do
  Event.create(
      title: fake_words(12).capitalize,
      description: fake_sentences(12),
      in_ticker: random_boolean,
      happens_at:  DateTime.now + rand(100).days
  )
end
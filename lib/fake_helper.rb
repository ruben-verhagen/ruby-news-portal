require 'faker'

Faker::Config.locale = :en

def fake_words(approximate_count=10)
  start_count = (approximate_count * 0.6).to_i
  start_count = 1 if start_count.zero?

  end_count = (approximate_count * 1.4).to_i

  words = Faker::Lorem.words (start_count..end_count).to_a.sample
  words.join(' ')
end

def fake_sentences(approximate_count=10)
  start_count = (approximate_count * 0.6).to_i
  start_count = 1 if start_count.zero?

  end_count = (approximate_count * 1.4).to_i

  sentences = Faker::Lorem.sentences (start_count..end_count).to_a.sample
  sentences.join(' ')
end

def fake_paragraphs(approximate_count=10)
  start_count = (approximate_count * 0.6).to_i
  start_count = 1 if start_count.zero?

  end_count = (approximate_count * 1.4).to_i

  paragraphs = Faker::Lorem.paragraphs (start_count..end_count).to_a.sample
  paragraphs.map { |s| '<p>' << s << '</p>' }.join('')
end

def fake_file(format=:jpg, index=nil)
  allowed_formats = %i[doc docx jpg mp4 ogv pdf ppt pptx webm]

  @cache ||= {}
  if allowed_formats.include? format
    @cache["#{format}#{index}"] ||= open(Rails.root.join("samples/example#{index}.#{format.to_s}"))
  end
end

def fake_image
  fake_file(:jpg, rand(3))
end

def fake_date(period_before=1.year)
  rand(period_before).ago
end

def random_model(*class_names)
  class_names.sample.order('RANDOM()').first
end

def random_models(class_name, max_count=1)
  count = rand(max_count)
  count = 1 if count.zero?
  class_name.order('RANDOM()').limit(count)
end

def random_boolean(true_probability=0.5)
  true_probability >= Random.rand(1.0)
end

def random_categories
  @cats ||= Category.pluck(:system_name)

  @cats.shuffle.take(rand(5))
end

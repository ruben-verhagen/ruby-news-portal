namespace :generate do
  task :pdf => :environment do
    generator = ArticlePdfGenerator.new([Post.friendly.find('qui-aut-iure-excepturi-repellendus-et-in-tenetur-iste-sint-magni-voluptatum-totam-dolorem-maiores-vel')])

    generator.render_file(Rails.root.join('tmp', 'generated-pdfs', 'weekly-digest.pdf'))
  end
end
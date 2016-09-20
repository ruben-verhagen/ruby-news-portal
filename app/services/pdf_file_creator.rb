class PdfFileCreator

  def self.create(posts)

    return nil if posts.empty?

    filename = "MNI-Euro-Insight-weekly-briefing-#{ I18n.l Date.today }.pdf"
    generator = ArticlePdfGenerator.new(posts, date: I18n.l(Time.zone.now, format: :short))

    tempfile = Tempfile.new(filename)
    tempfile.binmode
    tempfile << generator.render
    tempfile.rewind
    file_params = { filename: filename, tempfile: tempfile, type: 'application/pdf'}

    ActionDispatch::Http::UploadedFile.new(file_params)
  end
end
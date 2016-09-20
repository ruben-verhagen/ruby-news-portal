Rails.application.config.assets.precompile += %w( admin.css simple.css  frontend.css frontend-print.css
                                                  admin.js  simple.js   frontend.js
                                                  landing.css landing.js
                                                  wysiwyg-color.css *.eot *.woff *.ttf
                                                  )
Rails.application.config.assets.precompile += %w( ckeditor/* )
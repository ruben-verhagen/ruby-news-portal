class PostSectionCoverUploader < ImageUploader
  version(:thumb_small)   { process resize_to_fill: [100, 70] }
  version(:thumb)   { process resize_to_fill: [160, 160] }
  version(:sidebar) { process resize_to_fill: [238, 150] }
end
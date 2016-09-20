class PostCoverUploader < ImageUploader
  version(:thumb)   { process resize_to_fill:   [160, 160] }
  version(:main)    { process resize_to_fill:   [969, 621] }
  version(:pdf)     { process resize_to_limit:  [969, nil] }
  version(:square)  { process resize_to_fill:   [280, 280] }
  version(:sidebar) { process resize_to_fill:   [238, 150] }
  version(:option)  { process resize_to_fit:    [239, nil] }
end
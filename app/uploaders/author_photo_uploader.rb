class AuthorPhotoUploader < ImageUploader
  version(:main){ process resize_to_fit: [239, nil] }
end
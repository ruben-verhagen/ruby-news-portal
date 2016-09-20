window.AdminApp.controller 'GalleryController', ($scope, $fileUploader, GalleryPhoto) ->
  $scope.showProgressBar = false

  GalleryPhoto.query({ gallery_id: $scope.galleryId}).then (galleryPhotos) ->
    $scope.galleryPhotos = galleryPhotos

  $scope.uploader = $fileUploader.create
    scope: $scope
    headers:
      'X-CSRF-TOKEN' : window.csrfToken
    formData: [{ gallery_id: $scope.galleryId} ]
    url: '/admin/gallery_photos'

  $scope.uploader.bind 'afteraddingall', (event, items) ->
    $scope.showProgressBar = true
    @uploadAll()

  $scope.uploader.bind 'success', (event, xhr, item, response) ->
    if xhr.status == 200
      gp = new GalleryPhoto(response)
      $scope.galleryPhotos.push gp

  $scope.uploader.bind 'completeall', (event, items) ->
    $scope.showProgressBar = false

  # Images only
  $scope.uploader.filters.push (item) ->
    type = if $scope.uploader.isHTML5 then item.type else '/' + item.value.slice(item.value.lastIndexOf('.') + 1)
    type = '|' + type.toLowerCase().slice(type.lastIndexOf('/') + 1) + '|'

    '|jpg|png|jpeg|bmp|gif|'.indexOf(type) != -1


  $scope.updateGalleryPhoto = (galleryPhoto) ->
    galleryPhoto.save()

  $scope.removeGalleryPhoto = (galleryPhoto) ->
    if confirm('Do you really want to delete this photo?')
      galleryPhoto.delete().then ->
        index = $scope.galleryPhotos.indexOf galleryPhoto
        $scope.galleryPhotos.splice index, 1 if index isnt -1
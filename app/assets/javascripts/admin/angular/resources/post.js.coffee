window.AdminApp.factory 'Post', ($resource) ->
  $resource "/admin/posts/:postId", { postId: '@slug'},
    updatePositions:
      method: 'PUT',
      url: 'posts/update-positions'
    delete:
      method: 'DELETE'
      url: 'posts/:postId',
      params: { postId: '@slug'}
window.AdminApp.controller 'PostsController', ($scope, $timeout, Post) ->
  $scope.posts = Post.query()

  $scope.postsSortable =
    handle: '.handle'
    containment : "parent"
    cursor : "move"
    tolerance : "pointer"
    update: (event, ui) ->
      $timeout ->
        updatePostsOrder(ui.item.scope())
      , 300


  $scope.deletePost = (idx) ->
    p = $scope.posts[idx]
    if confirm('Remove post \n"' + p.headline + '"?')
      p.$delete ->
        $scope.posts.splice(idx, 1)

  updatePostsOrder = ($scope)->
    orderedIds = $scope.posts.map (p) -> p.id
    Post.updatePositions({ ordered_ids: orderedIds })


  #ng-sortable-on-change="onChange"
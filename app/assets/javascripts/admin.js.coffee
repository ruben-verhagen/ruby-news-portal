
#= require jquery
#= require jquery_ujs
#= require jquery-migrate-1.2.1.min
#= require jquery.slimscroll.min
#= require jquery.blockui.min
#= require jquery.cokie.min
#= require jquery.dataTables
#= require DT_bootstrap
#= require unslider.min
#= require select2

#= require bootstrap.min
#= require bootstrap-hover-dropdown.min
#= require bootstrap-datetimepicker.min

#= require bootstrap-timepicker.min
#= require jquery.multi-select

#= require ckeditor/init

#= require angular.min
#= require angular-resource
#= require angularjs/rails/resource
#= require angular-rails-templates
#= require ng-rails-csrf
#= require angular-file-upload
#= require xeditable

#= require admin/core/app
#= require admin/core/datatable

#= require admin/posts

#= require_tree ./admin/angular

#= require_self


$(document).ready ->
  App.init()
  $('.timepicker-input').timepicker()
  $('[data-custom-select]').select2({})

  $('[data-datetime-picker]').datetimepicker
    autoclose: true
    isRTL: true
    pickerPosition: "bottom-right"


  tagsField = $('[data-tag-list]')
  tagsList = tagsField.data('tag-list')
  tagsField.select2({ tags: tagsList })

  hiddenAuthorsSelect = $("[type='hidden'][name='post[author_ids_ordered]']")
  authorsPicker = $('[data-authors-picker]')

  if hiddenAuthorsSelect.length > 0 && authorsPicker.length > 0
    initialAuthorIds = hiddenAuthorsSelect.val().split(',')
    hiddenAuthorsSelect.val('')

    authorsPicker.multiSelect
      keepOrder: true
      afterSelect: (id) ->
        ids = hiddenAuthorsSelect.val().split(',')
        ids.push(id)
        hiddenAuthorsSelect.val(ids.join(','))

      afterDeselect: (items_ids) ->
        ids = hiddenAuthorsSelect.val().split(',')
        index = ids.indexOf(items_ids[0])

        if index >= 0
          ids.splice(index, 1)
          hiddenAuthorsSelect.val(ids.join(','))

      afterInit: (data) ->
        this.deselect_all()
        for id in initialAuthorIds
          this.select(id)
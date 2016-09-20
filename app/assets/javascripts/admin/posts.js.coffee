$ ->
  ###
  $('.table-posts').dataTable(
    aoColumns: [
      { "bSortable": false },
      { "bSortable": false },
      null,
      null,
      null,
      null,
      { "bSortable": false },
      { "bSortable": false }
    ],
    aLengthMenu: [
      [5, 10, 20, -1],
      [5, 10, 20, "All"]
    ],
    iDisplayLength: 20,
    sPaginationType: "bootstrap",
    oLanguage: {
      "sLengthMenu": "_MENU_ records",
      "oPaginate": {
        "sPrevious": "Prev",
        "sNext": "Next"
      }
    },
    aoColumnDefs: [
      { 'bSortable': false, 'aTargets': [0] },
      { "bSearchable": false, "aTargets": [ 0 ] }
    ]
  );

  $(".column").disableSelection();
###

###
  $(".sortable-post-attachments").sortable(
    items: ".portlet-container",
    handle: ".portlet-title",
    opacity: 0.8,
    coneHelperSize: true,
    placeholder: 'sortable-box-placeholder round-all',
    forcePlaceholderSize: true,
    tolerance: "pointer",
    stop: (event, ui) ->
      container = $(ui.item)
      Helpers.reinitializeWysihtml5Editor(container)

  )

###

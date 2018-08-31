//= require datatables/jquery.dataTables
//= require datatables/dataTables.bootstrap4

// optional change '//' --> '//=' to enable

// require datatables/extensions/AutoFill/dataTables.autoFill
// require datatables/extensions/Buttons/dataTables.buttons
// require datatables/extensions/Buttons/buttons.html5
// require datatables/extensions/Buttons/buttons.print
// require datatables/extensions/Buttons/buttons.colVis
// require datatables/extensions/Buttons/buttons.flash
// require datatables/extensions/ColReorder/dataTables.colReorder
// require datatables/extensions/FixedColumns/dataTables.fixedColumns
// require datatables/extensions/FixedHeader/dataTables.fixedHeader
// require datatables/extensions/KeyTable/dataTables.keyTable
// require datatables/extensions/Responsive/dataTables.responsive
// require datatables/extensions/RowGroup/dataTables.rowGroup
// require datatables/extensions/RowReorder/dataTables.rowReorder
// require datatables/extensions/Scroller/dataTables.scroller
// require datatables/extensions/Select/dataTables.select

// require datatables/extensions/AutoFill/autoFill.bootstrap

//= require datatables/extensions/Responsive/dataTables.responsive
//= require datatables/extensions/Responsive/responsive.bootstrap4
//= require datatables/extensions/Buttons/dataTables.buttons
//= require datatables/extensions/Buttons/buttons.html5
//= require datatables/extensions/Buttons/buttons.print
//= require datatables/extensions/Buttons/buttons.bootstrap4

//https://github.com/DataTables/DataTablesSrc/blob/master/js/ext/ext.classes.js#L7
$.extend( $.fn.dataTableExt.oStdClasses, {
    // "sWrapper": 'display nowrap table table-hover dataTable',
    "sFilter": 'float-right',
    "sFilterInput": 'form-control m-input m-input--solid',
} );

window.datatables = window.datatables || {};

function setDatatableLocale(currentLocale) {
    if (typeof currentLocale === 'undefined') {
        currentLocale = I18n.locale;
    }

    switch (currentLocale) {
        case 'en':
            return {
                "sEmptyTable": "No data available in table",
                "sInfo": "Showing _START_ to _END_ of _TOTAL_ entries",
                "sInfoEmpty": "Showing 0 to 0 of 0 entries",
                "sInfoFiltered": "(filtered from _MAX_ total entries)",
                "sInfoPostFix": "",
                "sInfoThousands": ",",
                "sLengthMenu": "_MENU_",
                "sLoadingRecords": "Loading...",
                "sProcessing": "Processing...",
                "sSearch": "_INPUT_",
                "sSearchPlaceholder": "Search...",
                "sZeroRecords": "No matching records found",
                "oPaginate": {
                    "sFirst": "<i class='fas fa-angle-double-left'></i>",
                    "sLast": "<i class='fas fa-angle-double-right'></i>",
                    "sNext": "<i class='fas fa-angle-right'></i>",
                    "sPrevious": "<i class='fas fa-angle-left'></i>"
                },
                "oAria": {
                    "sSortAscending": ": activate to sort column ascending",
                    "sSortDescending": ": activate to sort column descending"
                }
            };
            break;

        case 'el':
            return {
                "sDecimal": ",",
                "sEmptyTable": "Δεν υπάρχουν δεδομένα στον πίνακα",
                "sInfo": "Εμφανίζονται _START_ έως _END_ από _TOTAL_ εγγραφές",
                "sInfoEmpty": "Εμφανίζονται 0 έως 0 από 0 εγγραφές",
                "sInfoFiltered": "(φιλτραρισμένες από _MAX_ συνολικά εγγραφές)",
                "sInfoPostFix": "",
                "sInfoThousands": ".",
                "sLengthMenu": "Δείξε _MENU_ εγγραφές",
                "sLoadingRecords": "Φόρτωση...",
                "sProcessing": "Επεξεργασία...",
                "sSearch": "Αναζήτηση:",
                "sSearchPlaceholder": "Αναζήτηση",
                "sThousands": ".",
                "sUrl": "",
                "sZeroRecords": "Δεν βρέθηκαν εγγραφές που να ταιριάζουν",
                "oPaginate": {
                    "sFirst": "Πρώτη",
                    "sPrevious": "Προηγούμενη",
                    "sNext": "Επόμενη",
                    "sLast": "Τελευταία"
                },
                "oAria": {
                    "sSortAscending": ": ενεργοποιήστε για αύξουσα ταξινόμηση της στήλης",
                    "sSortDescending": ": ενεργοποιήστε για φθίνουσα ταξινόμηση της στήλης"
                }
            };
            break;
    }
}

function initDatatable(_table, params) {
    var table_id = _table.attr('id');

    var dom = "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
        "<'table-responsive'tr>" +
        "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>";
    var columns = [];
    var method = 'GET';
    var processing = true;
    var serverSide = true;

    if (typeof params !== 'undefined') {
        if (params.columns) {
            columns = params.columns;
        }

        if (params.dom) {
            dom = params.dom;
        }

        if (params.method) {
            method = params.method;
        }

        if (typeof params.processing !== 'undefined') {
            serverSide = params.processing;
        }

        if (typeof params.serverSide !== 'undefined') {
            serverSide = params.serverSide;
        }
    }

    var options = {
        language: setDatatableLocale(locale),
        processing: processing,
        serverSide: false,
        responsive: true,
        dom: dom,
        pagingType: "full_numbers",
        autoWidth: false,
        columns: columns,
        lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
        pageLength: 25,
        order: [],
        columnDefs: [
            {targets: 'no-sort', orderable: false},
            {targets: 'no-search', searchable: false},
            {targets: 'text-center', class: 'text-center'},
            {targets: 'text-right', class: 'text-right'},
            {targets: 'dt-options', class: 'dt-options', orderable: false, searchable: false},
            {targets: 'hidden', class: 'hidden'}
        ]
    };

    if(serverSide){
        options.ajax = {
            type: method,
            url: _table.data('source')
        };

        options.serverSide = true;
    }

    window.datatables[table_id] = _table.dataTable(options);
}

// function initDataTable(_table, params){
//     _table = typeof _table === 'string' ? $(_table) : _table;
//
//     var table_id = _table.attr('id');
//     var method = _table.data('method') ? _table.data('method') : 'get';
//     var dom = _table.data('dom') ? _table.data('dom') : "<'row'<'col-sm-6'l><'col-sm-6'>><'table-responsive'tr><'row'<'col-sm-5'i><'col-sm-7'p>>";
//
//     var options = {
//         language: setDatatableLocale(locale),
//         dom: dom,
//         processing: true,
//         serverSide: true,
//         responsive: true,
//         ajax: {
//             type: method,
//             url: _table.data('source')
//         },
//         pagingType: "full_numbers",
//         autoWidth: false,
//         lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
//         pageLength: 25,
//         order: [],
//         columnDefs: [
//             {targets: 'no-sort', orderable: false},
//             {targets: 'no-search', searchable: false},
//             {targets: 'text-center', class: 'text-center'},
//             {targets: 'text-right', class: 'text-right'},
//             {targets: 'dt-options', class: 'dt-options', orderable: false, searchable: false},
//             {targets: 'hidden', class: 'hidden'}
//         ]
//     };
//
//     if(typeof params !== 'undefined'){
//         $.each(params, function (key, value) {
//             options[key] = value;
//         });
//     }
//
//     window.datatables[table_id] = _table.dataTable(options);
//
//     // FIXME on multiple tables on same page, work as one
//     _table.parents('.dataTables_wrapper').find(".dataTables_filter input").unbind().bind('keydown', function(e){
//         if(e.keyCode === 13){
//             e.preventDefault();
//
//             window.datatables[table_id].search($(this).val()).draw();
//         }
//     });
//
//     // Setup - add a text input to each footer cell
//     _table.find('.search-columns th:not(.no-search, .dt-options)').each( function () {
//         if(!$(this).hasClass('select_option')){
//             var width = $(this).data('width') ? 'width:' + $(this).data('width') : '';
//             var _class = '';
//
//             if($(this).hasClass('address_country')){
//                 _class = 'address_country';
//             }else if($(this).hasClass('address_city')){
//                 _class = 'address_city';
//             }else if($(this).hasClass('address_location')){
//                 _class = 'address_location';
//             }
//
//             $(this).html( '<input class="form-control input-sm '+ _class +'" type="text" style="'+width+'">' );
//         }
//     });
//
//     // Apply the search
//     window.datatables[table_id].columns().every( function () {
//         var that = this;
//
//         $( 'input, select', this.footer() ).on( 'keydown change', function (e) {
//             if(e.keyCode === 13){
//                 e.preventDefault();
//
//                 that.search( this.value ).draw();
//             }
//         } );
//     } );
// }
//
// function simpleDataTable(_table, params){
//     _table = typeof _table === 'string' ? $(_table) : _table;
//
//     if(!$.fn.DataTable.isDataTable(_table)){
//         var table_id = _table.attr('id');
//         var dom = _table.data('dom') ? _table.data('dom') : "<'row'<'col-sm-6'l><'col-sm-6'>><'table-responsive'tr><'row'<'col-sm-5'i><'col-sm-7'p>>";
//
//         var options = {
//             language: setDatatableLocale(locale),
//             dom: dom,
//             responsive: true,
//             processing: true,
//             serverSide: false,
//             autoWidth: false,
//             lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
//             pageLength: 25,
//             order: [],
//             columnDefs: [
//                 {targets: 'no-sort', orderable: false},
//                 {targets: 'no-search', searchable: false},
//                 {targets: 'text-center', class: 'text-center'},
//                 {targets: 'text-right', class: 'text-right'},
//                 {targets: 'dt-options', class: 'dt-options', orderable: false, searchable: false},
//                 {targets: 'hidden', class: 'hidden'}
//             ]
//         };
//
//         if(typeof params !== 'undefined'){
//             $.each(params, function (key, value) {
//                 options[key] = value;
//             });
//         }
//
//         window.datatables[table_id] = _table.dataTable(options);
//
//         _table.parents('.dataTables_wrapper').find(".dataTables_filter input").unbind().bind('keydown', function(e){
//             if(e.keyCode === 13){
//                 e.preventDefault();
//
//                 window.datatables[table_id].search($(this).val()).draw();
//             }
//         });
//
//         // Setup - add a text input to each footer cell
//         _table.find('.search-columns th:not(.no-search, .dt-options)').each( function () {
//             if(!$(this).hasClass('select_option')){
//                 var width = $(this).data('width') ? 'width:' + $(this).data('width') : '';
//                 var _class = '';
//
//                 if($(this).hasClass('address_country')){
//                     _class = 'address_country';
//                 }else if($(this).hasClass('address_city')){
//                     _class = 'address_city';
//                 }else if($(this).hasClass('address_location')){
//                     _class = 'address_location';
//                 }
//
//                 $(this).html( '<input class="form-control input-sm ' + _class + '" type="text" style="'+width+'">' );
//             }
//         });
//
//         // Apply the search
//         window.datatables[table_id].columns().every( function () {
//             var that = this;
//
//             $( 'input, select', this.footer() ).on( 'keydown change', function (e) {
//                 if(e.keyCode === 13){
//                     e.preventDefault();
//
//                     that.search( this.value ).draw();
//                 }
//             } );
//         } );
//     }
// }
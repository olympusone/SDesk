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
// require datatables/extensions/Buttons/dataTables.buttons
// require datatables/extensions/Buttons/buttons.html5
// require datatables/extensions/Buttons/buttons.print
// require datatables/extensions/Buttons/buttons.bootstrap4

//https://github.com/DataTables/DataTablesSrc/blob/master/js/ext/ext.classes.js#L7
$.extend( $.fn.dataTableExt.oStdClasses, {
    // "sWrapper": 'display nowrap table table-hover dataTable',
    "sFilter": 'float-right',
    "sFilterInput": 'form-control m-input m-input--solid',
} );

window.datatables = window.datatables || {};

function setDatatableLocale(currentLocale) {
    if (typeof currentLocale === 'undefined') {
        currentLocale = 'el';
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
                "sEmptyTable": "Παρακαλώ συμπληρώστε τα κριτήρια σας",
                "sInfo": "Εμφανίζονται _START_ έως _END_ από _TOTAL_ εγγραφές",
                "sInfoEmpty": "Εμφανίζονται 0 έως 0 από 0 εγγραφές",
                "sInfoFiltered": "(φιλτραρισμένες από _MAX_ συνολικά εγγραφές)",
                "sInfoPostFix": "",
                "sInfoThousands": ".",
                "sLengthMenu": "Δείξε _MENU_ εγγραφές",
                "sLoadingRecords": "Φόρτωση...",
                "sProcessing": "Επεξεργασία...",
                "sSearch": "_INPUT_",
                "sSearchPlaceholder": "Αναζήτηση",
                "sThousands": ".",
                "sUrl": "",
                "sZeroRecords": "Δεν βρέθηκαν εγγραφές που να ταιριάζουν",
                "oPaginate": {
                    "sFirst": "<i class='fas fa-angle-double-left'></i>",
                    "sLast": "<i class='fas fa-angle-double-right'></i>",
                    "sNext": "<i class='fas fa-angle-right'></i>",
                    "sPrevious": "<i class='fas fa-angle-left'></i>"
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
    let table_id = _table.attr('id');

    let dom = "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
        "<'table-responsive'tr>" +
        "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>";
    let columns = [];
    let data = [];
    let method = 'GET';
    let processing = true;
    let serverSide = true;
    let additionalData = null;
    let createdRow = null;

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

        if(typeof params.data !== 'undefined'){
            data = params.data;
        }

        if(typeof params.additionalData !== 'undefined'){
            additionalData = params.additionalData;
        }

        if(typeof params.createdRow !== 'undefined'){
            createdRow = params.createdRow;
        }
    }

    let options = {
        language: setDatatableLocale('el'),
        processing: processing,
        serverSide: false,
        responsive: true,
        dom: dom,
        pagingType: "full_numbers",
        autoWidth: false,
        columns: columns,
        lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
        pageLength: 10,
        order: [],
        columnDefs: [
            {targets: 'currency', class: 'text-center text-nowrap'},
            {targets: 'text-center', class: 'text-center'},
            {targets: 'text-right', class: 'text-right'},
            {targets: 'dt-options', class: 'dt-options', orderable: false, searchable: false},
            {targets: 'hidden', class: 'hidden'}
        ]
    };

    if(serverSide){
        options.ajax = {
            type: method,
            url: _table.data('source'),
        };

        if(!_.isEmpty(additionalData)){
            options.ajax.data = additionalData;
        }

        options.serverSide = true;
    }

    if(!_.isEmpty(data)){
        options.data = data;
    }

    // TODO
    // if(!_.isEmpty(createdRow)){
    //     console.log('fds');
    //     options.createdRow = createdRow;
    // }

    window.datatables[table_id] = _table.DataTable(options);
}
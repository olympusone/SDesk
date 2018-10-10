class TicketTemplateDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :table_actions, :current_user, :icon, :link_to

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        name: {source: 'TicketTemplate.name'},
        subject: {source: 'TicketTemplate.subject'},
        active: {source: 'TicketTemplate.active', searchable: false},
        actions: {orderable: false, searchable: false},
    }
  end

  def data
    records.map do |record|
      {
          name: record.name,
          subject: record.subject,
          active: (icon('fas', 'circle', class: (record.active? ? 'text-success' : 'text-default'))),
          actions: table_actions(record, :edit, destroy: {remote: true}),
          DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    TicketTemplate.dt_order(params)
  end
end

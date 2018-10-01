class SolutionCategoryDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :table_actions, :current_user, :icon, :link_to

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        name: {source: 'SolutionCategory.name'},
        actions: {orderable: false, searchable: false},
    }
  end

  def data
    records.map do |record|
      {
          name: link_to(record.name, record),
          actions: table_actions(record, edit:{remote: true}, destroy: {remote: true}),
          DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    SolutionCategory.dt_order(params)
  end
end

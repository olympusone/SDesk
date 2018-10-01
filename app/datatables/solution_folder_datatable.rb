class SolutionFolderDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :table_actions, :current_user, :icon, :link_to

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        name: {source: 'SolutionFolder.name'},
        solution_category: {source: 'SolutionCategory.name'},
        actions: {orderable: false, searchable: false},
    }
  end

  def data
    records.map do |record|
      {
          name: link_to(record.name, record),
          solution_category: link_to(record.solution_category.name, record.solution_category),
          actions: table_actions(record, edit:{remote: true}, destroy: {remote: true}),
          DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    SolutionFolder.dt_order(params).includes(:solution_category).references(:solution_categories)
  end
end

class SolutionDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :table_actions, :current_user, :icon, :link_to

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        title: {source: 'Solution.title'},
        solution_folder: {source: 'SolutionFolder.name'},
        actions: {orderable: false, searchable: false},
    }
  end

  def data
    records.map do |record|
      {
          title: link_to(record.title, record),
          solution_folder: link_to(record.solution_folder.name, record.solution_folder),
          actions: table_actions(record, :edit, destroy: {remote: true}),
          DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Solution.dt_order(params).includes(:solution_folder).references(:solution_folders)
  end
end

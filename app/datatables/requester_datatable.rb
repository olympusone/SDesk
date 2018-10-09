class RequesterDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :table_actions, :current_user, :icon, :link_to

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        name: {source: 'Requester.name'},
        lastname: {source: 'Requester.lastname'},
        department: {source: 'Company.name'},
        email: {source: 'User.email'},
        state: {source: 'User.state'},
        actions: {orderable: false, searchable: false},
    }
  end

  def data
    records.map do |record|
      state = [icon('fas', 'circle', class: (record.user.confirmed? ? 'text-success' : 'text-default'))]
      state <<  icon('fas', "lock") if record.user.access_locked?

      {
          name: link_to(record.name, record),
          lastname: link_to(record.lastname, record),
          company: record.company.try(:name),
          email: record.user.email,
          state: state.join(" ").html_safe,
          actions: table_actions(record, :edit, destroy: {remote: true}),
          DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Requester.dt_order(params).includes(:user, :company).references(:users, :companies)
  end
end

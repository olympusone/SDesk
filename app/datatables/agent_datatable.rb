class AgentDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :table_actions, :current_user, :icon, :link_to

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        name: {source: 'Agent.name'},
        lastname: {source: 'Agent.lastname'},
        department: {source: 'Department.name'},
        email: {source: 'User.email'},
        state: {source: 'User.state'},
        actions: {orderable: false, searchable: false},
    }
  end

  def data
    records.map do |record|
      state = [icon('fas', 'circle', class: (record.user.confirmed? ? 'text-success' : 'text-default'))]
      state <<  icon('fas', "lock") if record.user.access_locked?

      if record == current_user
        _actions = table_actions(record, :edit)
      else
        _actions = table_actions(record, :edit, destroy: {remote: true})
      end

      {
          name: link_to(record.name, record),
          lastname: link_to(record.lastname, record),
          department: record.department.try(:name),
          email: record.user.email,
          state: state.join(" ").html_safe,
          actions: _actions,
          DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Agent.dt_order(params).includes(:user, :department).references(:users, :departments)
  end
end

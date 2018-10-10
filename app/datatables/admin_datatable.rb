class AdminDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :table_actions, :current_user, :icon, :link_to

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        name: {source: 'Admin.name'},
        lastname: {source: 'Admin.lastname'},
        email: {source: 'User.email'},
        state: {orderable: false, searchable: false},
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
          name: record.name,
          lastname: record.lastname,
          email: record.user.email,
          state: state.join(" ").html_safe,
          actions: _actions,
          DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Admin.dt_order(params).includes(:user).references(:users)
  end
end

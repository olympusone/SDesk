class UserDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :table_actions, :current_user, :icon, :link_to

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        username: {source: 'User.username'},
        gender: {source: 'User.gender'},
        role: {source: 'User.role'},
        country: {source: 'User.country'},
        state: {orderable: false, searchable: false},
        balance: {source: 'User.balance'},
        actions: {orderable: false, searchable: false},
    }
  end

  def data
    records.map do |record|
      state = [icon('fas', 'circle', class: (record.confirmed? ? 'text-success' : 'text-default'))]
      state <<  icon('fas', "lock") if record.access_locked?

      if record == current_user
        _actions = table_actions(record, :edit)
      else
        _actions = table_actions(record, :edit, destroy: {remote: true})
      end

      {
          username: link_to(record.username, record),
          gender: record.gender_text,
          role: record.role_text,
          country: record.country_name,
          state: state.join(" ").html_safe,
          balance: record.balance,
          actions: _actions,
          DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    User.dt_order(params)
  end
end

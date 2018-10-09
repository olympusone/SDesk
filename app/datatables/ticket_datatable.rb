class TicketDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :table_actions, :current_user, :icon, :link_to

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        requester: {source: 'Requester.lastname'},
        agent: {source: 'Agent.lastname'},
        department: {source: 'Department.name'},
        subject: {source: 'Ticket.subject'},
        priority: {source: 'Ticket.priority'},
        state: {source: 'Ticket.state'},
        actions: {orderable: false, searchable: false},
    }
  end

  def data
    records.map do |record|
      {
          requester: link_to(record.requester.try(:lastname), record.requester, target: :blank),
          agent: link_to(record.agent.try(:lastname), record.agent, target: :blank),
          department: link_to(record.department.try(:name), record.department, target: :blank),
          subject: link_to(record.subject, record),
          priority: link_to(record.priority_text, record),
          state: link_to(record.state_text, record),
          actions: table_actions(record, edit:{remote: true}, destroy: {remote: true}),
          DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Ticket.dt_order(params).includes(:requester, :agent, :department).references(:requesters, :agents, :departments)
  end
end

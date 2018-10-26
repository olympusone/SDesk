class TicketDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :table_actions, :current_user, :icon, :link_to, :link_to_if, :can?, :edit_ticket_path

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
          requester: link_to_if(can?(:show, record.requester), record.requester.try(:fullname), record.requester, target: :blank),
          agent: link_to_if((record.agent && can?(:read, record.agent)), record.agent.try(:lastname), record.agent, target: :blank),
          department: record.department.try(:name),
          subject: link_to(record.subject, edit_ticket_path(record)),
          priority: record.priority_text,
          state: record.state_text,
          actions: table_actions(record, :edit, destroy: {remote: true}),
          DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    query = []

    query << "tickets.requester_id = #{current_user.user_id}" if current_user.role? :requester

    if params[:agent_id].present?
      query << "tickets.agent_id = #{params[:agent_id]}"
    elsif params[:requester_id].present?
      query << "tickets.requester_id = #{params[:requester_id]}"
    end

    Ticket.dt_order(params)
        .includes(:requester, :agent, :department)
        .references(:requesters, :agents, :departments)
        .where(query.join(' AND ') || nil)
  end
end

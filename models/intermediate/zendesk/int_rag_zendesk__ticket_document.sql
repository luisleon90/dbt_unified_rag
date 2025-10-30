{{ config(enabled=var('rag__using_zendesk', True)) }}

with tickets as (
    select *
    from {{ ref('unified_rag','stg_rag_zendesk__ticket') }}

), users as (
    select *
    from {{ ref('unified_rag','stg_rag_zendesk__user') }}

), ticket_details as (
    select
        tickets.ticket_id,
        replace(replace(cast(tickets.url as {{ dbt.type_string() }}), '/api/v2/tickets/', '/agent/tickets/'), '.json', '') as url_reference,
        tickets.source_relation,
        {{ fivetran_demo_downstream.coalesce_cast(["tickets.title", "'UNKNOWN'"], dbt.type_string()) }} as title,
        {{ fivetran_demo_downstream.coalesce_cast(["users.name", "'UNKNOWN'"], dbt.type_string()) }} as user_name,
        {{ fivetran_demo_downstream.coalesce_cast(["users.email", "'UNKNOWN'"], dbt.type_string()) }} as created_by,
        {{ fivetran_demo_downstream.coalesce_cast(["tickets.created_at", "'1970-01-01 00:00:00'"], dbt.type_timestamp()) }} as created_on,
        {{ fivetran_demo_downstream.coalesce_cast(["tickets.status", "'UNKNOWN'"], dbt.type_string()) }} as status,
        {{ fivetran_demo_downstream.coalesce_cast(["tickets.priority", "'UNKNOWN'"], dbt.type_string()) }} as priority
    from tickets
    left join users
        on tickets.requester_id = users.user_id
        and tickets.source_relation = users.source_relation
    where not coalesce(tickets._fivetran_deleted, False)
        and not coalesce(users._fivetran_deleted, False)

), final as (
    select
        ticket_id,
        title,
        source_relation,
        url_reference,
        created_on,
        {{ dbt.concat([
            "'# Ticket : '", "title", "'\\n\\n'",
            "'Created By : '", "user_name", "' ('", "created_by", "')\\n'",
            "'Created On : '", "created_on", "'\\n'",
            "'Status : '", "status", "'\\n'",
            "'Priority : '", "priority"
        ]) }} as ticket_markdown
    from ticket_details
)

select 
    *,
    {{ fivetran_demo_downstream.count_tokens("ticket_markdown") }} as ticket_tokens
from final
{{ config(enabled=var('rag__using_jira', True)) }}

with issues as (

    select *
        --specify the jira subdomain value in your `dbt_project.yml` to generate the proper link to your issue (for our purposes, it would be 'fivetraninc') to generate proper Fivetran Jira links.
        {% if var('jira_subdomain', default=None) %}
        ,'{{ var("jira_subdomain") }}' as jira_subdomain_value
        {% endif %}
    from {{ ref('unified_rag','stg_rag_jira__issue') }}
), 

users as (

    select *
    from {{ ref('unified_rag','stg_rag_jira__user') }}
), 

{% if var('rag_jira_using_priorities', True) %}
priorities as (

    select *
    from {{ ref('unified_rag','stg_rag_jira__priority') }}
),
{% endif %}

statuses as (

    select *
    from {{ ref('unified_rag','stg_rag_jira__status') }}
),

issue_details as (

    select
        issues.issue_id,
        {{ fivetran_demo_downstream.coalesce_cast(["issues.title", "'UNKNOWN'"], dbt.type_string()) }} as title,
        {% if var('jira_subdomain', default=None) %}
            {{ dbt.concat(["'https://'", "jira_subdomain_value", "'.atlassian.net/browse/'", "issues.issue_key"]) }} as url_reference,
        {% else %}
            cast(null as {{ dbt.type_string() }}) as url_reference,
        {% endif %}
        issues.source_relation,
        {{ fivetran_demo_downstream.coalesce_cast(["users.user_display_name", "'UNKNOWN'"], dbt.type_string()) }} as user_name,
        {{ fivetran_demo_downstream.coalesce_cast(["users.email", "'UNKNOWN'"], dbt.type_string()) }} as created_by,
        {{ fivetran_demo_downstream.coalesce_cast(["issues.created_at", "'1970-01-01 00:00:00'"], dbt.type_timestamp()) }} as created_on,
        {{ fivetran_demo_downstream.coalesce_cast(["statuses.status_name", "issues.status_id", "'UNKNOWN'"], dbt.type_string()) }} as status,
        {% if var('jira_using_priorities', True) %}
            {{ fivetran_demo_downstream.coalesce_cast(["priorities.priority_name", "issues.priority_id", "'UNKNOWN'"], dbt.type_string()) }} as priority
        {% else %}
            {{ fivetran_demo_downstream.coalesce_cast(["issues.priority_id", "'UNKNOWN'"], dbt.type_string()) }} as priority
        {% endif %}
    from issues
    left join users
        on issues.reporter_user_id = users.user_id 
        and issues.source_relation = users.source_relation
    left join statuses
        on issues.status_id = statuses.status_id
    {% if var('jira_using_priorities', True) %}
    left join priorities 
        on issues.priority_id = priorities.priority_id
    {% endif %}
), 

final as (

    select
        issue_id,
        title,
        source_relation,
        url_reference,
        created_on,
        {{ dbt.concat([
            "'# issue : '", "title", "'\\n\\n'",
            "'Created By : '", "user_name", "' ('", "created_by", "')\\n'",
            "'Created On : '", "created_on", "'\\n'",
            "'Status : '", "status", "'\\n'",
            "'Priority : '", "priority"
        ]) }} as issue_markdown
    from issue_details
)

select 
    *,
    {{ fivetran_demo_downstream.count_tokens("issue_markdown") }} as issue_tokens
from final
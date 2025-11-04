{% macro sync_catalogs() %}
  
  {{ log("Starting catalog sync - dropping and recreating Iceberg tables in AWS Glue catalog...", info=True) }}

  
  {# Define your SQL statements for dropping and recreating tables #}
  {% set sql_statements = [
    
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__COMPANY",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__COMPANY_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__CONTACT",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__CONTACT_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__DEAL",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__DEAL_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_COMPANY",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_COMPANY_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_CONTACT",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_CONTACT_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_DEAL",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_DEAL_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_EMAIL",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_EMAIL_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_NOTE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__ENGAGEMENT_NOTE_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__OWNER",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_HUBSPOT__OWNER_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_JIRA__COMMENT",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_JIRA__COMMENT_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_JIRA__ISSUE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_JIRA__ISSUE_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_JIRA__PRIORITY",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_JIRA__PRIORITY_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_JIRA__STATUS",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_JIRA__STATUS_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_JIRA__USER",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_JIRA__USER_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_ZENDESK__TICKET",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_ZENDESK__TICKET_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_ZENDESK__TICKET_COMMENT",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_ZENDESK__TICKET_COMMENT_BASE",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_ZENDESK__USER",
    "DROP ICEBERG TABLE IF EXISTS AwsDataCatalog.dbt_lleon_unified_rag_source.STG_RAG_ZENDESK__USER_BASE",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__company EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__company'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__company_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__company_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__contact EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__contact'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__contact_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__contact_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__deal EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__deal'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__deal_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__deal_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_company EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_company'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_company_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_company_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_contact EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_contact'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_contact_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_contact_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_deal EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_deal'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_deal_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_deal_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_email EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_email'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_email_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_email_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_note EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_note'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__engagement_note_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__engagement_note_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__owner EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__owner'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_hubspot__owner_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_hubspot__owner_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_jira__comment EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_jira__comment'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_jira__comment_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_jira__comment_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_jira__issue EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_jira__issue'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_jira__issue_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_jira__issue_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_jira__priority EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_jira__priority'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_jira__priority_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_jira__priority_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_jira__status EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_jira__status'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_jira__status_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_jira__status_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_jira__user EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_jira__user'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_jira__user_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_jira__user_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_zendesk__ticket EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_zendesk__ticket'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_zendesk__ticket_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_zendesk__ticket_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_zendesk__ticket_comment EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_zendesk__ticket_comment'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_zendesk__ticket_comment_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_zendesk__ticket_comment_base'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_zendesk__user EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_zendesk__user'",
    
    "CREATE ICEBERG TABLE dbt_lleon_unified_rag_source.stg_rag_zendesk__user_base EXTERNAL_VOLUME = 'luis_leon_demo_bucket_iceberg' CATALOG = 'luis_demo_glue_iceberg_catalog_rag_source' CATALOG_TABLE_NAME = 'stg_rag_zendesk__user_base'"
    
  ] %}
  
  {# Execute each SQL statement #}
  {% for sql in sql_statements %}
    {{ log("Executing: " ~ sql[:80] ~ "...", info=True) }}
    {% do run_query(sql) %}
  {% endfor %}
  
 {# Log completion #}
  {{ log("Catalog sync completed successfully! All 37 Iceberg tables have been dropped and recreated.", info=True) }}
  
  
{% endmacro %}
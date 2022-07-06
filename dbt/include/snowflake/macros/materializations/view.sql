{% materialization view, adapter='snowflake' -%}

    {% set original_query_tag = set_query_tag() %}
    {% set copy_grants = config.get('copy_grants', False) %}

    {% set to_return = create_or_replace_view(are_grants_copied_over=copy_grants) %}

    {% set target_relation = this.incorporate(type='view') %}

    {% do persist_docs(target_relation, model, for_columns=false) %}

    {% do return(to_return) %}

    {% do unset_query_tag(original_query_tag) %}

{%- endmaterialization %}

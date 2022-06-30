
{%- macro agg_event(event_type) %}
    max(case when event_type='{{event_type}}' then 1.0 else 0 end)
{%- endmacro %}
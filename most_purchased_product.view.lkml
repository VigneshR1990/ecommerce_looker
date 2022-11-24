view: most_purchased_product {
  derived_table: {
    sql: SELECT productName, COUNT(*) FROM `bq-sln.ecommerce_bq_looker.events_flat` LEFT JOIN UNNEST(items) as items where event_name ='purchase' and productname != '(not set)' GROUP BY 1 ORDER BY 2 DESC LIMIT 100
      ;;
    datagroup_trigger:bqsln_ecommerce_default_datagroup
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.productName ;;
  }

  dimension: f0_ {
    type: number
    sql: ${TABLE}.f0_ ;;
  }

  set: detail {
    fields: [product_name, f0_]
  }
}

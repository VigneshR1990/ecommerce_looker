view: orders_by_year {
  derived_table: {
    sql: SELECT  LEFT(orderDate, 4) as orderYear ,count(LEFT(orderDate, 4) ) as count FROM `bq-sln.ecommerce_bq_looker.orders` group by LEFT(orderDate, 4)
      ;;
    materialized_view: yes
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_year {
    type: string
    sql: ${TABLE}.orderYear ;;
  }

  dimension: count_ {
    type: number
    sql: ${TABLE}.count ;;
  }

  set: detail {
    fields: [order_year, count_]
  }
}

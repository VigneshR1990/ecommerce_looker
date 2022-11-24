view: premium_customers {
  derived_table: {
    sql: -- SELECT price, COUNT(*) FROM `bq-sln.ecommerce_bq_looker.orders` LEFT JOIN UNNEST(lineItems) as lineItems GROUP BY 1 ORDER BY 2 DESC LIMIT 100


      SELECT
      userid,
      SUM(lineItems.price) AS total_amount_spent,
      SUM(CAST(uniqueItemsQuantity AS int)) AS total_products_bought
      FROM
      `ecommerce_bq_looker.orders`
      LEFT JOIN UNNEST(lineItems) as lineItems
      GROUP BY
      userid

      ;;
    materialized_view: yes
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
  }

  dimension: total_amount_spent {
    type: number
    sql: ${TABLE}.total_amount_spent ;;
  }

  dimension: total_products_bought {
    type: number
    sql: ${TABLE}.total_products_bought ;;
  }

  set: detail {
    fields: [userid, total_amount_spent, total_products_bought]
  }
}

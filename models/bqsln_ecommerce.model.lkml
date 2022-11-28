connection: "bqsln_looker"

# include all the views
include: "/views/**/*.view"
include: "../premium_customers.view"
include: "../orders_by_year.view"
datagroup: bqsln_ecommerce_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;

}

persist_with: bqsln_ecommerce_default_datagroup

explore: users {
  join: premium_customers {
    type: left_outer
    sql_on: ${users.user_id} = ${premium_customers.userid} ;;
    relationship: one_to_one
  }
}

explore: connection_reg_r3 {}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }

  join: orders__line_items {
    view_label: "Orders: Lineitems"
    sql: LEFT JOIN UNNEST(${orders.line_items}) as orders__line_items ;;
    relationship: one_to_many
  }

  join: orders_by_year {
    type: left_outer

    sql_on: LEFT(${orders.user_id} , 4)  = ${orders_by_year.order_year} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: events_flat {
  join: orders {
    type: left_outer
    sql_on: ${events_flat.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${events_flat.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }

  join: events_flat__items {
    view_label: "Events Flat: Items"
    sql: LEFT JOIN UNNEST(${events_flat.items}) as events_flat__items ;;
    relationship: one_to_many
  }
}

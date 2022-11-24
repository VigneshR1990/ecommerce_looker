test: order_date_is_accurate {
  explore_source: orders {
    column: order_date {
      field: orders.order_date
    }

  }

  assert: order_date_is_expected_value {
    expression: NOT is_null(${orders.order_date}) ;;

  }
}


test: unique_items_quantity_is_accurate {
  explore_source: orders {
    column: unique_items_quantity {
      field: orders.unique_items_quantity
    }

  }
  assert: unique_items_quantity_is_expected_value {

    expression: NOT is_null(${orders.unique_items_quantity}) ;;
  }

}

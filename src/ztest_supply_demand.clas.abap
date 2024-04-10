CLASS ztest_supply_demand DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
 INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
   " Data Declaration
    TYPES:
      " Supply Table
      BEGIN OF gty_supply_tab,
        product_id    TYPE matnr,        " Product ID
        prod_desc     TYPE string,       " Product Description
        pavail_dat    TYPE c LENGTH 10,  " Product Available Date
        prod_quantity TYPE menge_d,      " Product quantity
      END OF gty_supply_tab,

      " Demand Table
      BEGIN OF gty_demand_tab,
        cust_id       TYPE c LENGTH 10,    " Customer ID
        cust_name     TYPE name1_gp,       " Customer Name
        product_id    TYPE matnr,          " Product ID
        req_date      TYPE c LENGTH 10,    " Required Date of Product
        req_quantity  TYPE menge_d,        " Required quantity
        vip_indicator TYPE c LENGTH 1,     " VIP Customer Indicator
      END OF gty_demand_tab,

          " Output table
      BEGIN OF gty_output,
        product_id        TYPE matnr,        " Product ID
        cust_id           TYPE c LENGTH 10,  " Customer ID
        cust_name         TYPE name1_gp,     " Customer Name
        vip_indicator     TYPE c LENGTH 1,   " VIP Customer Indicator
        req_date          TYPE c LENGTH 10,  " Required Date of Product
        req_quantity      TYPE menge_d,      " Required quantity
        status            TYPE string,       " Demand supply Status
        can_delivered_qty TYPE menge_d,      " Quantity can be delivered
        pavail_dat        TYPE c LENGTH 10,  " Available Date
        undelivered_qty   TYPE menge_d,
      END OF gty_output,

      gtty_output type STANDARD TABLE OF gty_output WITH NON-UNIQUE KEY product_id.

    " Internal table
    DATA : gt_supply TYPE STANDARD TABLE OF gty_supply_tab,
           gt_demand TYPE STANDARD TABLE OF gty_demand_tab.
    " Methods
    METHODS add_Process_data RETURNING VALUE(rt_output) type gtty_output.

ENDCLASS.


CLASS ztest_supply_demand IMPLEMENTATION.

method if_oo_adt_classrun~main.
out->write( add_process_data(  ) ).
ENDMETHOD.

method add_process_data.

" Add data to internal table for Supply
gt_supply = VALUE #(
                    ( product_id    =   '1602'  prod_desc   =   'Castle'        pavail_dat  =   '2024-05-18'    prod_quantity   =   '1200' )
                    ( product_id    =   '2081'  prod_desc   =   'Pirate Ship'   pavail_dat  =   '2024-05-17'    prod_quantity   =   '400'  )
                    ( product_id    =   '2081'  prod_desc   =   'Pirate Ship'   pavail_dat  =   '2024-05-23'    prod_quantity   =   '400'  )
                    ( product_id    =   '3000'  prod_desc   =   'Car'           pavail_dat  =   '2024-05-08'    prod_quantity   =   '1450' )
                    ( product_id    =   '4382'  prod_desc   =   'Spaceship'     pavail_dat  =   '2024-05-12'    prod_quantity   =   '7400' )
                    ( product_id    =   '5906'  prod_desc   =   'Train'         pavail_dat  =   '2024-05-18'    prod_quantity   =   '1750' )
                    ( product_id    =   '5906'  prod_desc   =   'Train'         pavail_dat  =   '2024-05-25'    prod_quantity   =   '1750' )
                    ( product_id    =   '6353'  prod_desc   =   'Firestation'   pavail_dat  =   '2024-05-19'    prod_quantity   =   '400'  )
                    ( product_id    =   '6353'  prod_desc   =   'Firestation'   pavail_dat  =   '2024-05-19'    prod_quantity   =   '250'  )
                    ( product_id    =   '7851'  prod_desc   =   'Bulldozer'     pavail_dat  =   '2024-05-08'    prod_quantity   =   '335'  )
                    ( product_id    =   '9112'  prod_desc   =   'Roses'         pavail_dat  =   '2024-05-09'    prod_quantity   =   '1200' )
                    ( product_id    =   '9112'  prod_desc   =   'Roses'         pavail_dat  =   '2024-05-16'    prod_quantity   =   '950'  )
                    ( product_id    =   '9112'  prod_desc   =   'Roses'         pavail_dat  =   '2024-05-21'    prod_quantity   =   '670'  )
                    ).
sort gt_supply ASCENDING by product_id.

" Add data to Internal table for Demand
gt_demand = VALUE #(
                     ( cust_id  =   '91389' cust_name   =   'Toys’R’Us'   product_id  =   '1602'  req_date    =   '2024-05-20'    req_quantity    =   '480'   vip_indicator   =   ''  )
                    ( cust_id   =   '92043' cust_name   =   'Walmart'     product_id  =   '1602'  req_date    =   '2024-05-21'    req_quantity    =   '640'   vip_indicator   =   'X' )
                    ( cust_id   =   '93011' cust_name   =   'Hobby Town'  product_id  =   '2081'  req_date    =   '2024-05-19'    req_quantity    =   '650'   vip_indicator   =   'X' )
                    ( cust_id   =   '94211' cust_name   =   'Target'      product_id  =   '3000'  req_date    =   '2024-05-02'    req_quantity    =   '780'   vip_indicator   =   ''  )
                    ( cust_id   =   '91389' cust_name   =   'Toys’R’Us'   product_id  =   '4382'  req_date    =   '2024-05-14'    req_quantity    =   '5000'  vip_indicator   =   ''  )
                    ( cust_id   =   '92043' cust_name   =   'Walmart'     product_id  =   '4382'  req_date    =   '2024-05-14'    req_quantity    =   '2200'  vip_indicator   =   'X' )
                    ( cust_id   =   '94211' cust_name   =   'Target'      product_id  =   '5906'  req_date    =   '2024-05-20'    req_quantity    =   '1500'  vip_indicator   =   ''  )
                    ( cust_id   =   '93011' cust_name   =   'Hobby Town'  product_id  =   '5906'  req_date    =   '2024-05-21'    req_quantity    =   '350'   vip_indicator   =   'X' )
                    ( cust_id   =   '92043' cust_name   =   'Walmart'     product_id  =   '5906'  req_date    =   '2024-05-24'    req_quantity    =   '620'   vip_indicator   =   'X' )
                    ( cust_id   =   '91389' cust_name   =   'Toys’R’Us'   product_id  =   '6353'  req_date    =   '2024-05-19'    req_quantity    =   '440'   vip_indicator   =   ''  )
                    ( cust_id   =   '93011' cust_name   =   'Hobby Town'  product_id  =   '7851'  req_date    =   '2024-05-09'    req_quantity    =   '580'   vip_indicator   =   'X' )
                    ( cust_id   =   '91389' cust_name   =   'Toys’R’Us'   product_id  =   '8359'  req_date    =   '2024-05-03'    req_quantity    =   '410'   vip_indicator   =   ''  )
                    ( cust_id   =   '92043' cust_name   =   'Walmart'     product_id  =   '8359'  req_date    =   '2024-05-05'    req_quantity    =   '130'   vip_indicator   =   'X' )
                    ( cust_id   =   '92043' cust_name   =   'Walmart'     product_id  =   '9112'  req_date    =   '2024-05-01'    req_quantity    =   '1000'  vip_indicator   =   'X' )
                    ( cust_id   =   '91389' cust_name   =   'Toys’R’Us'   product_id  =   '9112'  req_date    =   '2024-05-11'    req_quantity    =   '500'   vip_indicator   =   ''  )
                    ( cust_id   =   '93011' cust_name   =   'Hobby Town'  product_id  =   '9112'  req_date    =   '2024-05-13'    req_quantity    =   '500'   vip_indicator   =   'X' )
                    ( cust_id   =   '94211' cust_name   =   'Target'      product_id  =   '9112'  req_date    =   '2024-05-18'    req_quantity    =   '500'   vip_indicator   =   ''  ) ).

sort gt_demand by vip_indicator DESCENDING product_id.

" Process the data based on demands with prioritize VIP Customer
LOOP AT gt_demand INTO DATA(lwa_demand).

      " update output table
      APPEND INITIAL LINE TO rt_output ASSIGNING FIELD-SYMBOL(<lfs_output>).
      <lfs_output>-product_id = lwa_demand-product_id.
      <lfs_output>-cust_id = lwa_demand-cust_id.
      <lfs_output>-cust_name = lwa_demand-cust_name.
      <lfs_output>-vip_indicator = lwa_demand-vip_indicator.
      <lfs_output>-req_date = lwa_demand-req_date.
      <lfs_output>-req_quantity = lwa_demand-req_quantity.
      <lfs_output>-status = 'UNFULLFILED'.

      LOOP AT gt_supply ASSIGNING FIELD-SYMBOL(<lfs_supply>) WHERE product_id = lwa_demand-product_id AND
                                                    pavail_dat LE lwa_demand-req_date.


        IF <lfs_supply>-prod_quantity GE lwa_demand-req_quantity.
          " Demand Fullfiled
          <lfs_supply>-prod_quantity = <lfs_supply>-prod_quantity - lwa_demand-req_quantity.

          " Update output table
          <lfs_output>-status = 'DEMAND FULLFILED'.
          <lfs_output>-can_delivered_qty = lwa_demand-req_quantity.
          <lfs_output>-pavail_dat = <lfs_supply>-pavail_dat.
          <lfs_output>-undelivered_qty = 0.
        ELSE.
          " Partially Demand Fullfiled

          " Update output table
          <lfs_output>-status = 'PARTIALLY DEMAND FULLFILED'.
          <lfs_output>-can_delivered_qty = <lfs_supply>-prod_quantity.
          <lfs_output>-pavail_dat = <lfs_supply>-pavail_dat.
          <lfs_output>-undelivered_qty = lwa_demand-req_quantity - <lfs_supply>-prod_quantity.

        ENDIF.

      ENDLOOP.
    ENDLOOP.

ENDMETHOD.
ENDCLASS.

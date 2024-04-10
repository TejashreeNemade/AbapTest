**Case Description:**

To Generate a SAP report that provides an overview of currently planned supply i.e production at the factory and how it compares with demands from customers.

**Program Attributes:**

Class Name : ztest_supply_demand

**Technical Logic Flow:**

1. Data Declaration( Types, Internal tables) and  to fetch Supply and Demand data: 
   In the SAP system, Supply and Demand data will be fetched from the Database table. 
   For this case in eclipse, sample data is directly added in internal tables for Supply and   Demand.

2. Processing Logic to evaluate the result based on Available quantity, Dates(Available and Required) and Customer VIP status

3. Display the output for the User:
    Output report is displayed with below fields:
   
    PRODUCT_ID (Product ID)
    CUST_ID   (Customer ID)
    CUST_NAME (Customer Name)
    VIP_INDICATOR (Customer VIP Status)
    REQ_DATE  (Required Date from Customer) 
    REQ_QUANTITY  (Product Quantity Required)
    STATUS  (Demand fulfillment Status)
        If ‘DEMAND FULFILLED’ : Customer Demand for the product is fulfilled
        If ‘DEMAND PARTIALLY FULFILLED’ : Customer Demand for the product is partially fulfilled. Field ‘UNDELIVERED_QTY’ will display unfulfilled Demand Quantity.
        If ‘UNFULFILLED’  : Customer Demand cannot be fulfilled on the required date. In this case, fields DELIVERED_QTY, DELIVERY_DAT and  
                            UNDELIVERED_QTY are blank
    DELIVERED_QTY (Quantity which can be delivered) 
    DELIVERY_DAT (Available date of product from Factory)
    UNDELIVERED_QTY (Undelivered Quantity from Order/demand)


**Processing Logic with pseudo code:**

Each Demand/Order is checked against supply for the product and availability dates.
( pavail_dat LE lwa_demand-req_date)
Demand from VIP customers is prioritized first. This is achieved by sorting demand data based on VIP_customer status.

If a product is available, quantity is verified from supply data based on required quantity.
(IF <lfs_supply>-prod_quantity GE lwa_demand-req_quantity.) 

If demand is fulfilled, the Output table is updated with the data and the Available quantity of the product in the Supply table is modified with the remaining quantity.
(<lfs_supply>-prod_quantity = <lfs_supply>-prod_quantity - lwa_demand-req_quantity.)

If Demand is partially fulfilled, the Output table is updated accordingly.
In Output, Field Undelivered_Qty will display the quantity which cannot be fulfilled.
(<lfs_output>-undelivered_qty = lwa_demand-req_quantity - <lfs_supply>-prod_quantity.)

If Product is not available on the required date, Status in Output table is set as ‘UNFULFILLED’.


**Output:**

Below is the screenshot of output from Eclipse.

![Output_supply_demand](https://github.com/TejashreeNemade/AbapTest/assets/166565717/17614c7d-1ac0-4d9d-b518-b7b291d84b86)


**Output in table format:**

PRODUCT_ID    CUST_ID    CUST_NAME     VIP_INDICATOR    REQ_DATE      REQ_QUANTITY    STATUS                        DELIVERED_QTY    DELIVERY_DAT    UNDELIVERED_QTY
1602          92043      Walmart       X                2024-05-21    640.0           DEMAND FULFILLED              640.0            2024-05-18      0.0            
2081          93011      Hobby Town    X                2024-05-19    650.0           DEMAND PARTIALLY FULFILLED    400.0            2024-05-17      250.0          
4382          92043      Walmart       X                2024-05-14    2200.0          DEMAND FULFILLED              2200.0           2024-05-12      0.0            
5906          93011      Hobby Town    X                2024-05-21    350.0           DEMAND FULFILLED              350.0            2024-05-18      0.0            
5906          92043      Walmart       X                2024-05-24    620.0           DEMAND FULFILLED              620.0            2024-05-18      0.0            
7851          93011      Hobby Town    X                2024-05-09    580.0           DEMAND PARTIALLY FULFILLED    335.0            2024-05-08      245.0          
8359          92043      Walmart       X                2024-05-05    130.0           UNFULFILLED                   0.0                              0.0            
9112          92043      Walmart       X                2024-05-01    1000.0          UNFULFILLED                   0.0                              0.0            
9112          93011      Hobby Town    X                2024-05-13    500.0           DEMAND FULFILLED              500.0            2024-05-09      0.0            
1602          91389      Toys’R’Us                      2024-05-20    480.0           DEMAND FULFILLED              480.0            2024-05-18      0.0            
3000          94211      Target                         2024-05-02    780.0           UNFULFILLED                   0.0                              0.0            
4382          91389      Toys’R’Us                      2024-05-14    5000.0          DEMAND FULFILLED              5000.0           2024-05-12      0.0            
5906          94211      Target                         2024-05-20    1500.0          DEMAND PARTIALLY FULFILLED    780.0            2024-05-18      720.0          
6353          91389      Toys’R’Us                      2024-05-19    440.0           DEMAND PARTIALLY FULFILLED    250.0            2024-05-19      190.0          
8359          91389      Toys’R’Us                      2024-05-03    410.0           UNFULFILLED                   0.0                              0.0            
9112          91389      Toys’R’Us                      2024-05-11    500.0           DEMAND FULFILLED              500.0            2024-05-09      0.0            
9112          94211      Target                         2024-05-18    500.0           DEMAND FULFILLED              500.0            2024-05-16      0.0            

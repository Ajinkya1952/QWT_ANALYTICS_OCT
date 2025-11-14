def model (dbt,session):
    customers_df = dbt.source("qwt_raw","customers")
    return customers_df
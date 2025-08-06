/*
This Query applies the promocodes to the price_per_night from the accommodations Entity.
In order to perfom this a join over promocodes and accommodations is required.
Price_per_night gets substracted by itself multiplied by the promocode discount.
*/
select promocodes.promo_code,promocodes.discount,accommodations.price_per_night,
accommodations.price_per_night- promocodes.discount*accommodations.price_per_night as calculated_amount, accommodations.accommodation_id 
from promocodes join accommodations on promocodes.promo_code_id = accommodations.promo_code_id;


/*
This Query converts the original price_per_night of usd to the desired currency.
To achieve this, the price per nights gets multiplied by the exchange rate.
*/
select accommodations.accommodation_id , accommodations.currency_id ,accommodations.price_per_night, currencies.currency_name ,currencies.exchange_rate,
accommodations.price_per_night*currencies.exchange_rate as converted_amount 
from accommodations join currencies on accommodations.currency_id= currencies.currency_id;


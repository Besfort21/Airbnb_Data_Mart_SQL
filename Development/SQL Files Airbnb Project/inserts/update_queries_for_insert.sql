/*
Query for updating the amount column in transactions.
The amount is calculated by the number of nights from bookings mulitplied by the price per night from accommodations.
*/
update transactions join bookings on transactions.booking_id = bookings.booking_id 
join accommodations on bookings.accommodation_id = accommodations.accommodation_id set transactions.amount = bookings.num_nights* accommodations.price_per_night;
/*
Query for updating the host column in transactions.
Setting the correct host for the corresponding accommodation in the transaction entity.
*/
update transactions join bookings on transactions.booking_id = bookings.booking_id 
join accommodations on bookings.accommodation_id = accommodations.accommodation_id set transactions.host_id = accommodations.host_id;
/*
Query for updating the country column in cities.
Setting the correct country for the corresponding city.
*/
update adresses join cities on adresses.city_id= cities.city_id 
set adresses.country_id = cities.country_id;
/*
Query for updating the country column in accommodation addresses.
Setting the correct country for the corresponding city.
*/
update accommodationadresses join cities on accommodationadresses.city_id= cities.city_id 
set accommodationadresses.country_id = cities.country_id;

/*
Update Query for setting the correct host for the accommodations.As a Requirement i set,
that the host needs to have his address in the same country where the accommodation is.
*/
update accommodations join accommodationadresses on accommodations.accommodation_adresse_id = accommodationadresses.accommodation_adresse_id 
join adresses on accommodationadresses.country_id = adresses.country_id 
join users on adresses.adress_id = users.adress_id 
join hostess on hostess.user_id = users.user_id
set accommodations.host_id = hostess.host_id;


create table if not exists AccommodationImages (
	accommodation_image_id int unique not null auto_increment,
    image varchar(35),
    primary key(accommodation_image_id)
);

create table if not exists AccommodationDescriptions (
	accommodation_description_id int unique not null auto_increment,
    acc_description text,
    primary key(accommodation_description_id)
);
create table if not exists AccommodationAmenitites (
	accommodation_amenitie_id int unique not null auto_increment,
    amenitie varchar(35),
    primary key(accommodation_amenitie_id)
);

create table if not exists AccommodationRoomTypes (
	accommodation_room_type_id int unique not null auto_increment,
    roomType varchar(35),
    primary key(accommodation_room_type_id)
);

create table if not exists AccommodationTypes (
	accommodation_type_id int unique not null auto_increment,
    acc_type varchar(35),
    primary key(accommodation_type_id)
);


create table if not exists ReviewBodys (
	review_body_id int unique not null auto_increment,
    reviewbBody text,
    primary key(review_body_id)
);

create table if not exists ReviewRatings (
	review_rating_id int unique not null auto_increment,
    reviewRating decimal(2,1),
    primary key(review_rating_id)
);

create table if not exists Reviews (
	review_id int unique not null auto_increment,
    review_rating_id int,
    review_body_id int,
    primary key(review_id),
    foreign key(review_body_id) references ReviewBodys(review_body_id),
	foreign key(review_rating_id) references ReviewRatings(review_rating_id)
);

create table if not exists Countries (
	country_id int unique not null auto_increment,
    country_code varchar(3),
    country_name varchar(35),
    primary key(country_id)
);

create table if not exists Cities (
	city_id int unique not null auto_increment,
    city_name varchar(35),
    country_id int,
    primary key(city_id),
    foreign key(country_id) references Countries(country_id)
);

create table if not exists AccommodationAdresses (
	accommodation_adresse_id int unique not null auto_increment,
    primary key(accommodation_adresse_id),
    city_id int,
    country_id int,
    street_name varchar(35),
    house_number varchar(3),
    foreign key(city_id) references Cities(city_id),
    foreign key(country_id) references Countries(country_id)
);

create table if not exists Adresses (
	adress_id int unique not null auto_increment,
    street_name varchar(35),
    house_number varchar(3),
    city_id int,
    country_id int,
    primary key(adress_id),
    foreign key(city_id) references Cities(city_id),
    foreign key(country_id) references Countries(country_id)
);

create table if not exists Users (
	user_id int unique not null auto_increment,
    first_name varchar(35),
    last_name varchar(35),
    email varchar(35) unique,
    date_of_birth date,
    primary key(user_id),
    adress_id int,
    foreign key(adress_id) references Adresses(adress_id)
);

create table if not exists Languages (
	language_id int unique not null auto_increment,
    language_name  varchar(35),
    primary key(language_id)
);

create table if not exists Hostess (
	host_id int unique not null auto_increment,
    user_id int,
    primary key(host_id),
    foreign key(user_id) references Users(user_id)
);

create table if not exists PromoCodes (
	promo_code_id int unique not null auto_increment,
    promo_code varchar(35),
    discount decimal(5,2),
    primary key(promo_code_id)
);

create table if not exists Currencies (
	currency_id int unique not null auto_increment,
    currency_name varchar(35),
    exchange_rate decimal(19,4),
    primary key(currency_id)
);

create table if not exists Accommodations (
	accommodation_id int unique not null auto_increment,
    price_per_night decimal,
    room_count int,
    bed_count int,
    accommodation_adresse_id int,
    accommodation_description_id int,
    accommodation_room_type_id int,
    accommodation_type_id int,
    host_id int,
    currency_id int,
    promo_code_id int,
    primary key(accommodation_id),
    foreign key(accommodation_adresse_id)references AccommodationAdresses(accommodation_adresse_id),
    foreign key(accommodation_description_id)references AccommodationDescriptions(accommodation_description_id),
    foreign key(accommodation_room_type_id)references AccommodationRoomTypes(accommodation_room_type_id),
    foreign key(accommodation_type_id)references AccommodationTypes(accommodation_type_id),
    foreign key(host_id)references Hostess(host_id),
    foreign key(currency_id)references Currencies(currency_id),
    foreign key(promo_code_id)references PromoCodes(promo_code_id)
);

/*
Join Table for accommodations and accommodation images.
*/
create table accommodation_images_join (
	accommodation_image_id int,
    accommodation_id int,
    primary key(accommodation_image_id,accommodation_id),
    foreign key(accommodation_image_id)references AccommodationImages(accommodation_image_id),
    foreign key(accommodation_id)references accommodations(accommodation_id)
);

/*
Join Table for accommodations and accommodation amenities.
*/
create table accommodation_amenities_join (
	accommodation_amenitie_id int,
    accommodation_id int,
    primary key(accommodation_amenitie_id,accommodation_id),
    foreign key(accommodation_amenitie_id)references accommodationamenitites(accommodation_amenitie_id),
    foreign key(accommodation_id)references accommodations(accommodation_id)
);

/*
Join Table for accommodations and reviews.
*/
create table accommodation_reviews_join (
	review_id int,
    accommodation_id int,
    primary key(review_id,accommodation_id),
    foreign key(review_id)references reviews(review_id),
    foreign key(accommodation_id)references accommodations(accommodation_id)
);

/*
Join Table for Hostess and Languages images.
*/
create table hostess_languages_join (
	host_id int,
    language_id int,
    primary key(host_id,language_id),
    foreign key(host_id)references hostess(host_id),
    foreign key(language_id)references languages(language_id)
);

create table if not exists Bookings (
	booking_id int unique not null auto_increment,
    start_date date,
    end_date date,
    num_nights int,
    accommodation_id int,
    user_id int,
    primary key(booking_id),
    foreign key(user_id)references Users(user_id),
    foreign key(accommodation_id)references Accommodations(accommodation_id)
);

create table if not exists Transactions (
	transaction_id int unique not null auto_increment,
    payment_date date,
    transfer_date date,
    amount decimal,
    user_id int,
    host_id int,
    booking_id int,
    primary key(transaction_id),
    foreign key(user_id)references Users(user_id),
    foreign key(host_id)references Hostess(host_id),
    foreign key (booking_id) references bookings(booking_id)
);


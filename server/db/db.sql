CREATE TABLE restaurants (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    price_range INT NOT NULL
);


CREATE TABLE reviews (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    restaurant_id BIGINT NOT NULL REFERENCES restaurants(id),
    name VARCHAR(50) NOT NULL,
    review TEXT NOT NULL,
    rating INT NOT NULL check(
        rating >= 1
        and rating <= 5
    )
);

INSERT INTO restaurants (name, location, price_range)
VALUES
('MacDonalds', 'Gdansk', 5),
('Pizza Hut', 'Gdynia', 6),
('Burger King', 'Sopot', 7),
('Italiano', 'Rumia', 8);

INSERT INTO reviews (restaurant_id, name, review, rating)
VALUES
(1, 'Adam', 'Bad', 1),
(2, 'Michael', 'So so', 2),
(3, 'Ursula', 'Not bad', 3),
(4, 'Anna', 'Great', 5);

select *
from restaurants
    left join(
        select restaurant_id,
            count(*),
            TRUNC(AVG(rating, 1)) as average_rating
        from reviews
        group by restaurant_id
    ) reviews on restaurants.id = reviews.restaurant_id;


SELECT restaurants.name, review
FROM restaurants
JOIN reviews ON restaurants.id = reviews.restaurant_id;
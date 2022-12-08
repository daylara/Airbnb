CREATE TABLE users(
	id int NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	password varchar(255) NOT NULL,
	phone_number varchar(255) NOT NULL,
	created_at datetime NOT NULL,
	updated_at datetime NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE city (
	id int NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE house (
	id int NOT NULL AUTO_INCREMENT,
	house_type  varchar(255) NOT NULL,
	total_bedrooms int NOT NULL,
	total_bathrooms int NOT NULL,
	num_guests int NOT NULL,
	has_tv tinyint(1) NOT NULL,
	has_kitchen tinyint(1) NOT NULL,
	has_air_con tinyint(1) NOT NULL,
	has_heating tinyint(1) NOT NULL,
	has_internet tinyint(1) NOT NULL,
	created_at datetime NOT NULL,
	updated_at datetime NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE adverts (
	id int NOT NULL AUTO_INCREMENT,
	price_per_day int NOT NULL,
	description varchar(255) NOT NULL,
	address varchar(255) NOT NULL,
	created_at datetime NOT NULL,
	updated_at datetime NOT NULL,
	city_id int NOT NULL,
	user_id int NOT NULL,
	house_id int NOT NULL,
	status tinyint(1) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (city_id) REFERENCES city(id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (house_id) REFERENCES house(id)
);

CREATE TABLE media (
  id int NOT NULL AUTO_INCREMENT,
  advert_id INT NOT NULL,
  image_url JSON NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (advert_id) REFERENCES adverts(id)
);

CREATE TABLE reservations(
	id int NOT NULL AUTO_INCREMENT,
	user_id int NOT NULL,
	advert_id int NOT NULL,
	check_in datetime NOT NULL,
	check_out datetime NOT NULL,
	price  int NOT NULL,
	created_at datetime NOT NULL,
	updated_at datetime NOT NULL,
	status tinyint(1) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (advert_id) REFERENCES adverts(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE reviews(
	id int NOT NULL AUTO_INCREMENT,
	reservation_id int NOT NULL,
	rating int NOT NULL,
	comment varchar(255) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (reservation_id) REFERENCES reservations(id)
	
);


INSERT INTO `city` VALUES (1,'West Ciaraberg'),
						(2,'Declanbury'),
						(3,'Littelland'),
						(4,'Nolaborough'),
						(5,'Ofeliamouth'),
						(6,'Michealside'),
						(7,'Wisokyburgh'),
						(8,'Lake Jovanyberg'),
						(9,'Alisaville'),
						(10,'Lake Mitchell');


INSERT INTO `users` VALUES (1,'Bron','bbice0@sfgate.com','awWxvp3u7','(189)576-5435','2016-07-08 01:20:41','1977-04-17 21:03:59'),
							(2,'Theodoric','tpinhorn1@blogger.com','C8RbqHW367VO','253-102-7724','1989-09-08 05:42:30','1988-01-22 11:52:00'),
							(3,'Inez','ilattie2@opera.com','dYZ909QJ9F','236-816-6546','2005-09-09 01:00:07','1994-02-06 03:11:06'),
							(4,'Ingmar','ipietron3@bandcamp.com','8nhyratV0tYH','443-531-8463','1987-04-18 21:36:51','1987-12-09 06:17:41'),
							(5,'Tessie','tknewstub4@yolasite.com','r0obOkTh','995-226-8791','1985-01-20 23:24:27','1982-05-26 03:38:30'),
							(6,'Benedikt','bmartyntsev5@usgs.gov','c27oYHV4wpj','522-350-7505','1989-09-17 14:37:31','1985-04-27 02:12:18'),
							(7,'Nesciunt','apargeter6@ning.com','9BQdF7OjGEX','(037)096-2058','2010-12-28 09:55:43','2010-12-31 10:06:09'),
							(8,'Analiese','mheinle9@hubpages.com','xvWYC6g','(897)592-8888','1990-07-19 21:00:19','1973-06-19 06:31:01'),
							(9,'Moishe','alessandro.jaskolski@example.com','8kyrvZO5dgbg','274-163-1704','1998-12-31 22:13:24','1986-03-02 07:42:57'),
							(10,'Germayne','vcorley7@weebly.com','QCK01vneH','928-640-5539','1996-03-27 14:29:50','2012-02-10 08:21:40');
							
						
INSERT INTO `house` VALUES (1,'tiny homes',3,3,9,true,false,true,true,true,'1974-06-06 08:09:00','2004-08-07 05:54:08'),
							(2,'Private rooms',2,6,2,false,true,true,true,false,'2003-01-03 04:19:59','1971-07-04 17:40:29'),
							(3,'trending',2,4,8,false,false,true,false,false,'2008-08-08 13:48:11','2010-02-20 01:19:49'),
							(4,'OMG!',7,2,9,true,true,true,true,true,'1998-06-04 02:19:05','2009-08-19 14:12:54'),
							(5,'Castles',7,5,5,true,true,true,false,true,'2004-03-21 13:15:10','1971-10-03 20:55:54'),
							(6,'A-frames',5,9,1,false,false,false,true,false,'2002-01-21 09:06:09','2008-03-15 12:49:21'),
							(7,'Domes',4,5,2,true,true,false,true,false,'2007-07-23 06:17:02','1981-02-10 02:52:57'),
							(8,'tiny homes',6,9,4,false,false,true,false,false,'1995-07-23 16:34:47','1995-07-28 11:37:01'),
							(9,'Private rooms',2,3,4,false,false,false,true,true,'1998-01-17 19:01:15','2010-02-15 22:29:07'),
							(10,'tiny homes',1,5,4,true,false,true,true,false,'2007-08-07 09:17:57','1978-04-29 12:10:54');


						
INSERT INTO `adverts` VALUES (1,296,'Magnam fugit illo et consequatur. Vel et maxime architecto velit quia. Fugit modi odio repudiandae rerum aperiam at.','858 Hermiston Run\nWest Anahi, WI 39045','2008-07-02 17:33:38','2008-04-19 21:23:46',1,1,1,false),
							(2,265,'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.','4405 Margret Cape\nMaggioville, MN 53096','1980-03-22 13:26:28','2005-10-12 14:58:31',2,2,2,false),
							(3,930,'Morbi porttitor lorem id ligula.','81559 Miguel Forks Suite 903\nMinniestad, OR 58215-2254','1990-07-16 19:48:57','1987-12-25 03:15:17',3,3,3,false),
							(4,84,'Mauris ullamcorper purus sit amet nulla.','32830 Purdy Camp\nLake Alvis, MA 66427-0559','1980-06-16 12:14:24','2014-11-22 12:12:29',4,4,4,true),
							(5,310,'Quia eius sed unde. Et minima praesentium cumque aut dolorem modi. Autem explicabo alias est voluptatum. Temporibus voluptatibus ut eos.','49361 Barton Ports\nNew Doyle, WI 76313','1986-05-12 01:35:31','1981-10-31 16:27:34',5,5,5,false),
							(6,0,'Rerum iste consequatur quod blanditiis ipsa. Officia ut enim mollitia doloremque doloremque quam quam. Ut ea et optio et. Dolores delectus fuga ad repudiandae reiciendis architecto sed.','78233 Johnson Villages Suite 187\nBurleystad, ME 53455','2019-06-03 00:22:27','1997-05-11 14:14:19',6,6,6,false),
							(7,675,'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','40511 Tia Cliffs\nSaulton, KS 14044-4881','2022-04-28 15:33:54','1984-04-15 20:10:43',7,7,7,true),
							(8,959,'Mauris ullamcorper purus sit amet nulla.','724 Pollich Views Apt. 931\nNew Trevion, OR 36643','1973-10-24 02:21:41','1970-04-26 15:55:13',8,8,8,true),
							(9,563,'Maecenas rhoncus aliquam lacus.','3996 Breanna Fall Suite 369\nDeckowhaven, SD 51615-5840','2021-03-21 11:24:37','2012-07-28 12:59:47',9,9,9,true),
							(10,382,'Morbi porttitor lorem id ligula.','512 Malcolm Glens\nLake Porter, PA 49342-1386','2011-10-04 02:06:11','2001-10-11 20:05:42',10,10,10,false);						

						
INSERT INTO `media` VALUES (1,1,'https://loremflickr.com/640/480/'),
						   (2,2,'https://loremflickr.com/640/480/'),
						   (3,3,'https://loremflickr.com/640/480/'),
						   (4,4,'https://loremflickr.com/640/480/'),
						   (5,5,'https://loremflickr.com/640/480/'),
						   (6,6,'https://loremflickr.com/640/480/'),
						   (7,7,'https://loremflickr.com/640/480/'),
						   (8,8,'https://loremflickr.com/640/480/'),
						   (9,9,'https://loremflickr.com/640/480/'),
						   (10,10,'https://loremflickr.com/640/480/');

INSERT INTO `media` VALUES (1,1, JSON_ARRAY(
    'https://a0.muscache.com/im/pictures/57e96162-6804-4773-bb59-dd5ca8e69e21.jpg?im_w=1200',
    'https://a0.muscache.com/im/pictures/41a530cd-f0ea-4716-bf6c-9e4fd997804d.jpg?im_w=720',
    'https://a0.muscache.com/im/pictures/e352de89-252f-436d-98ce-32517d8ffddf.jpg?im_w=720',
    'https://a0.muscache.com/im/pictures/d1c3be0e-b743-4826-bcf7-83acb196a493.jpg?im_w=720',
    'https://a0.muscache.com/im/pictures/44c4aaf6-3608-4f3c-8a2d-4318e9e47430.jpg?im_w=720'
  )
);
INSERT INTO `media` VALUES (2,2, JSON_ARRAY(
'https://a0.muscache.com/im/pictures/0d93e337-c49c-4bf5-83f4-982cb9f2e132.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/661bf5d6-5f89-4ab6-8397-86e1002f2c2d.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/5c9897c0-271e-4982-8392-da12c6ba373a.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/79fb2c80-bf4d-4a7e-8f66-9011fb14d814.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/c7a534fc-a289-4ca0-862b-282bad0b3487.jpg?im_w=720'
  )
);
INSERT INTO `media` VALUES (3,3, JSON_ARRAY(
'https://a0.muscache.com/im/pictures/3efc8fc3-0d9b-4ae3-a4ad-5acd2af63023.jpg?im_w=1200',
'https://a0.muscache.com/im/pictures/9e3f7acd-ca97-43fb-ab77-3e8284cbe489.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/bda69a7d-fd27-4407-8370-e891bb5338aa.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/67f7d021-b98f-4fa5-af13-f4aa13a38fd1.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/fe8e1eab-bb75-4cb9-a735-64d2c74120d7.jpg?im_w=720'
  )
);
INSERT INTO `media` VALUES (4,4, JSON_ARRAY(
'https://a0.muscache.com/im/pictures/c3fa3c40-4c21-4775-a478-599198f1979f.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/809ca1df-4009-4c7d-bc76-700ced9610ba.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/3ae268be-2695-4d3a-8b69-39c2178c7d08.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/74da68ea-4ffc-49c4-ba76-c2b0817b6543.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/40ab55f2-c0bf-4aee-8370-61d1044f5ec7.jpg?im_w=720'
  )
);
INSERT INTO `media` VALUES (5,5,JSON_ARRAY(
	'https://a0.muscache.com/im/pictures/miso/Hosting-713793474951553871/original/2ac03203-3d06-441c-bc82-77f28ac26c6a.jpeg?im_w=720',
                                    'https://a0.muscache.com/im/pictures/miso/Hosting-713793474951553871/original/467c73f5-711a-49c3-a358-bad81cfe4a02.jpeg?im_w=720',
                                    'https://a0.muscache.com/im/pictures/miso/Hosting-713793474951553871/original/a5049cbc-82f5-43f7-b536-1298c93f9d64.jpeg?im_w=720', 
                                    'https://a0.muscache.com/im/pictures/miso/Hosting-713793474951553871/original/06ec5b7b-0197-47f8-92e8-bffa074f9b1c.jpeg?im_w=720', 
                                    'https://a0.muscache.com/im/pictures/miso/Hosting-713793474951553871/original/779aef02-d2da-476a-a79c-b63e1b7807d2.jpeg?im_w=720%27')	);		

INSERT INTO `media` VALUES (6,6, JSON_ARRAY(
'https://a0.muscache.com/im/pictures/f4654645-07e9-4e65-96fe-49202784f33f.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/3e859cb9-5e77-4d66-98c0-e7fa82f1f16d.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/656a28c4-680c-437a-b6ab-2163176c6dfd.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/670e97e8-cd79-4d88-b11d-3c7f584f29fc.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/8efcc304-3a90-42b1-9534-3bf6fcc39031.jpg?im_w=720'
  )
);								
INSERT INTO `media` VALUES (7,7, JSON_ARRAY(
'https://a0.muscache.com/im/pictures/miso/Hosting-53356466/original/f353fb80-0915-40ab-8032-6bc810ac273e.jpeg?im_w=720',
'https://a0.muscache.com/im/pictures/miso/Hosting-53356466/original/80597541-a243-4938-b479-00995447f06c.jpeg?im_w=720',
'https://a0.muscache.com/im/pictures/miso/Hosting-53356466/original/6892e348-4447-4128-92e7-b805b94646d2.jpeg?im_w=720',
'https://a0.muscache.com/im/pictures/miso/Hosting-53356466/original/a90fdf8f-acc2-4ff0-82bc-8fdd4d24e0d4.jpeg?im_w=720',
'https://a0.muscache.com/im/pictures/miso/Hosting-53356466/original/c24bd6f6-c0bb-4968-9abb-7ecb1c32063b.jpeg?im_w=720'
  )
);								
INSERT INTO `media` VALUES (8,8, JSON_ARRAY(
'https://a0.muscache.com/im/pictures/miso/Hosting-661994800564477473/original/1933dd1c-d29f-4cf5-98ab-0196863ff43f.jpeg?im_w=1200',
'https://a0.muscache.com/im/pictures/miso/Hosting-661994800564477473/original/d09567cd-6e53-4b8e-a7ae-49cba492f3c4.jpeg?im_w=720',
'https://a0.muscache.com/im/pictures/miso/Hosting-661994800564477473/original/4e4b11bd-4307-424e-a2bd-c83c7efcc791.jpeg?im_w=720',
'https://a0.muscache.com/im/pictures/miso/Hosting-661994800564477473/original/59a40458-dea3-4afe-b16e-e5c7a219ca19.jpeg?im_w=720',
'https://a0.muscache.com/im/pictures/miso/Hosting-661994800564477473/original/2edb699a-a49c-4d13-9140-2e8dfdbc23cd.jpeg?im_w=720'
  )
);								
INSERT INTO `media` VALUES (9,9, JSON_ARRAY(
'https://a0.muscache.com/im/pictures/2fa4e833-2f21-4808-ba57-8a303f7484c1.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/bfd54bdc-fda5-447b-afdd-8c25055ee643.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/22c000ca-7ef4-49fc-a79d-936fabe9f500.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/c90ce006-2d32-4e2d-bd97-22dcc0d76cb1.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/e6cfe881-996c-4361-9034-d9f491be9e45.jpg?im_w=720'
  )
);								
INSERT INTO `media` VALUES (10,10, JSON_ARRAY(
'https://a0.muscache.com/im/pictures/345e30d1-c294-4237-82d7-eccd5a6f2110.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/9be612e3-08c8-4ee7-a748-fbb5d4e7e400.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/ed5e1d2b-8d32-47de-81bc-d3420dcecb08.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/665a1bfe-e9f8-4f0e-b5db-ab18b80d7cf4.jpg?im_w=720',
'https://a0.muscache.com/im/pictures/93e697c1-e149-4978-93be-f584f773c261.jpg?im_w=720'
  )
);								

						  
INSERT INTO `reservations` VALUES (1,1,1,'1991-03-26 12:32:36','1989-03-02 22:42:06',584,'2002-05-09 01:34:50','1973-08-16 14:07:17',false),
                                  (2,2,2,'1975-05-17 20:43:02','2005-07-02 13:57:28',2000,'1989-07-22 14:05:57','2007-07-31 13:02:53',false),
                                  (3,3,3,'2017-08-25 09:22:52','2012-04-19 09:55:25',2857,'1999-01-26 20:51:57','2012-08-02 16:29:09',false),
                                  (4,4,4,'1972-03-12 08:10:42','1983-11-19 21:11:06',30699,'1985-06-20 15:44:01','2004-05-26 19:23:35',false),
                                  (5,5,5,'1991-10-08 10:44:23','2010-10-05 03:54:29',5087,'1970-12-16 09:42:57','1983-05-09 21:09:50',true),
                                  (6,6,6,'1973-10-05 05:32:24','1980-03-18 22:00:50',6698,'1976-10-13 19:21:21','2015-06-23 11:06:22',false),
                                  (7,7,7,'2000-06-08 00:43:06','1987-03-15 23:56:31',4025,'2004-09-02 15:09:02','2014-05-28 00:07:48',true),
                                  (8,8,8,'1977-12-15 10:12:07','2014-01-07 02:28:56',508,'2006-08-16 06:03:22','1981-12-28 19:51:36',true),
                                  (9,9,9,'2017-05-03 15:29:53','1992-09-17 13:34:45',3534,'1991-11-08 17:10:02','2022-03-22 23:01:05',false),
                                  (10,10,10,'2013-03-22 10:01:33','2019-10-12 17:05:35',10340,'2003-08-09 02:52:38','1974-10-30 04:41:56',false);
                                 
INSERT INTO `reviews` VALUES (1,1,9,'Ex fuga modi dolor necessitatibus impedit animi asperiores error. Voluptatem sunt aperiam nesciunt nihil odio. Architecto exercitationem inventore perspiciatis omnis.'),
							(2,2,5,'Quisquam fuga cumque animi ratione similique neque ipsa. Assumenda qui ea aperiam expedita libero. Animi dolores vel maiores laboriosam doloribus id sed ullam. Est veniam quis dolorem porro sit vel.'),
							(3,3,4,'Ut voluptatem cum aliquid quisquam. Libero voluptatem accusantium nobis doloribus. Ut quas quo quo quia earum.'),
							(4,4,5,'Ducimus consequatur quos et quis. Veritatis quaerat qui ut. Veniam veniam ex sit mollitia quibusdam voluptatum velit ab. Error asperiores sapiente cumque ab fugit.'),
							(5,5,2,'Voluptatem aut libero delectus et eius nostrum illo. Voluptatibus voluptatem doloremque et excepturi asperiores facere. Quasi tenetur et enim porro. Dolore tempora iusto enim in.'),
							(6,6,5,'Nobis qui fugit velit culpa. Asperiores eum aut mollitia aspernatur et. Asperiores eius nobis repellendus. Cumque temporibus asperiores aut tempora voluptate.'),
							(7,7,4,'Inventore nesciunt minima nostrum molestiae. Dolores ab modi laborum facere. Aut asperiores ut deleniti rem. Est perferendis culpa magni nesciunt quam.'),
							(8,8,5,'Labore magnam temporibus quod explicabo quis. Iusto dolor ex possimus fuga ut laboriosam doloribus. Velit accusantium autem sequi esse. Nam hic id repellendus reiciendis tempora alias eius.'),
							(9,9,2,'Nesciunt qui minima molestiae. Eveniet excepturi et ab nam adipisci hic qui. Incidunt quo aut sint culpa quisquam quia.'),
							(10,10,4,'Debitis perspiciatis temporibus illum in alias dolorum soluta aut. Quisquam cumque nobis doloremque aut.');




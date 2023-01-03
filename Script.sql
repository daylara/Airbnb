CREATE TABLE users(
	id int NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	email varchar(255) NOT NULL UNIQUE,
	password varchar(255) NOT NULL,
	phone_number varchar(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE city (
	id int NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  text TEXT NOT NULL,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE adverts (
	id int NOT NULL AUTO_INCREMENT,
	price_per_day int NOT NULL,
	description varchar(255) NOT NULL,
	address varchar(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	city_id int NOT NULL,
	user_id int NOT NULL,
	house_id int NOT NULL,
	status tinyint(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	FOREIGN KEY (city_id) REFERENCES city(id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (house_id) REFERENCES house(id)
);

CREATE TABLE media (
  id int NOT NULL AUTO_INCREMENT,
  advert_id INT NOT NULL,
  image_url TEXT NOT NULL,
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
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	status tinyint(1) NOT NULL DEFAULT 0,
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

CREATE VIEW adverts_view AS
  SELECT a.*, GROUP_CONCAT(m.image_url) AS images
  FROM adverts a
  INNER JOIN media m ON a.id = m.advert_id
  GROUP BY a.id;

ALTER TABLE test.adverts DROP FOREIGN KEY adverts_ibfk_1;
ALTER TABLE test.adverts ADD CONSTRAINT adverts_ibfk_1 FOREIGN KEY (city_id) REFERENCES test.city(id) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE test.adverts DROP FOREIGN KEY adverts_ibfk_3;
ALTER TABLE test.adverts ADD CONSTRAINT adverts_ibfk_3 FOREIGN KEY (house_id) REFERENCES test.house(id) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE test.adverts DROP FOREIGN KEY adverts_ibfk_2;
ALTER TABLE test.adverts ADD CONSTRAINT adverts_ibfk_2 FOREIGN KEY (user_id) REFERENCES test.users(id) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE test.media DROP FOREIGN KEY media_ibfk_1;
ALTER TABLE test.media ADD CONSTRAINT media_ibfk_1 FOREIGN KEY (advert_id) REFERENCES test.adverts(id) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE test.adverts DROP FOREIGN KEY adverts_ibfk_3;
ALTER TABLE test.adverts ADD CONSTRAINT adverts_ibfk_3 FOREIGN KEY (house_id) REFERENCES test.house(id) ON DELETE CASCADE ON UPDATE CASCADE;
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



INSERT INTO `media` (advert_id, image_url)
VALUES
(1, 'https://a0.muscache.com/im/pictures/57e96162-6804-4773-bb59-dd5ca8e69e21.jpg?im_w=1200'),
(1, 'https://a0.muscache.com/im/pictures/41a530cd-f0ea-4716-bf6c-9e4fd997804d.jpg?im_w=720'),
(1, 'https://a0.muscache.com/im/pictures/e352de89-252f-436d-98ce-32517d8ffddf.jpg?im_w=720'),
(1, 'https://a0.muscache.com/im/pictures/d1c3be0e-b743-4826-bcf7-83acb196a493.jpg?im_w=720'),
(1, 'https://a0.muscache.com/im/pictures/44c4aaf6-3608-4f3c-8a2d-4318e9e47430.jpg?im_w=720');


INSERT INTO `media` (advert_id, image_url)
VALUES
(2, 'https://a0.muscache.com/im/pictures/0d93e337-c49c-4bf5-83f4-982cb9f2e132.jpg?im_w=720'),
(2, 'https://a0.muscache.com/im/pictures/661bf5d6-5f89-4ab6-8397-86e1002f2c2d.jpg?im_w=720'),
(2, 'https://a0.muscache.com/im/pictures/5c9897c0-271e-4982-8392-da12c6ba373a.jpg?im_w=720'),
(2, 'https://a0.muscache.com/im/pictures/79fb2c80-bf4d-4a7e-8f66-9011fb14d814.jpg?im_w=720'),
(2, 'https://a0.muscache.com/im/pictures/c7a534fc-a289-4ca0-862b-282bad0b3487.jpg?im_w=720');

INSERT INTO media (advert_id, image_url)
VALUES
(3, 'https://a0.muscache.com/im/pictures/3efc8fc3-0d9b-4ae3-a4ad-5acd2af63023.jpg?im_w=1200'),
(3, 'https://a0.muscache.com/im/pictures/9e3f7acd-ca97-43fb-ab77-3e8284cbe489.jpg?im_w=720'),
(3, 'https://a0.muscache.com/im/pictures/bda69a7d-fd27-4407-8370-e891bb5338aa.jpg?im_w=720'),
(3, 'https://a0.muscache.com/im/pictures/67f7d021-b98f-4fa5-af13-f4aa13a38fd1.jpg?im_w=720'),
(3, 'https://a0.muscache.com/im/pictures/fe8e1eab-bb75-4cb9-a735-64d2c74120d7.jpg?im_w=720'),

(4, 'https://a0.muscache.com/im/pictures/c3fa3c40-4c21-4775-a478-599198f1979f.jpg?im_w=720'),
(4, 'https://a0.muscache.com/im/pictures/809ca1df-4009-4c7d-bc76-700ced9610ba.jpg?im_w=720'),
(4, 'https://a0.muscache.com/im/pictures/3ae268be-2695-4d3a-8b69-39c2178c7d08.jpg?im_w=720'),
(4, 'https://a0.muscache.com/im/pictures/74da68ea-4ffc-49c4-ba76-c2b0817b6543.jpg?im_w=720'),
(4, 'https://a0.muscache.com/im/pictures/40ab55f2-c0bf-4aee-8370-61d1044f5ec7.jpg?im_w=720');

INSERT INTO media (advert_id, image_url)
VALUES
(5, 'https://a0.muscache.com/im/pictures/miso/Hosting-713793474951553871/original/467c73f5-711a-49c3-a358-bad81cfe4a02.jpeg?im_w=720'),
(5, 'https://a0.muscache.com/im/pictures/miso/Hosting-713793474951553871/original/a5049cbc-82f5-43f7-b536-1298c93f9d64.jpeg?im_w=720'), 
(5, 'https://a0.muscache.com/im/pictures/miso/Hosting-713793474951553871/original/06ec5b7b-0197-47f8-92e8-bffa074f9b1c.jpeg?im_w=720'), 
(5, 'https://a0.muscache.com/im/pictures/miso/Hosting-713793474951553871/original/779aef02-d2da-476a-a79c-b63e1b7807d2.jpeg?im_w=720%27'),
(6, 'https://a0.muscache.com/im/pictures/656a28c4-680c-437a-b6ab-2163176c6df4.jpg?im_w=720'),
(6, 'https://a0.muscache.com/im/pictures/8a7b29a0-f5cc-4847-8cfa-f96a78b1e7be.jpg?im_w=720'),
(6, 'https://a0.muscache.com/im/pictures/3833a9e9-8d47-46f4-b0f6-d4b8f7f4c4a4.jpg?im_w=720'),
(6, 'https://a0.muscache.com/im/pictures/4b6c4b6e-8f3c-4c12-b7ff-d2b8a7ebe6c4.jpg?im_w=720'),
(6, 'https://a0.muscache.com/im/pictures/24c5c1d1-ee2a-49dc-b5e5-0fdfc3e3e5b5.jpg?im_w=720'),
(5, 'https://a0.muscache.com/im/pictures/miso/Hosting-713793474951553871/original/2ac03203-3d06-441c-bc82-77f28ac26c6a.jpeg?im_w=720'),
(7, 'https://a0.muscache.com/im/pictures/e5dc5a5c-b8dd-4c79-832f-73b00ef9b5d5.jpg?im_w=720'),
(7, 'https://a0.muscache.com/im/pictures/14ba87c8-bde0-4cb0-b270-87d200b08f53.jpg?im_w=720'),
(7, 'https://a0.muscache.com/im/pictures/a1bbe686-d32d-4e7f-93b5-5b5e6d0f6e5c.jpg?im_w=720'),
(7, 'https://a0.muscache.com/im/pictures/c5a4fbe2-9f1c-4cdd-b2e7-72fbbd3a7fda.jpg?im_w=720'),
(7, 'https://a0.muscache.com/im/pictures/b7c33fff-4939-4787-9b2a-5d5ee5f5c542.jpg?im_w=720'),
(8, 'https://a0.muscache.com/im/pictures/40cc8e55-a738-4ec2-b7a8-9b4e3f3c3e6f.jpg?im_w=720'),
(8, 'https://a0.muscache.com/im/pictures/94453035/dd8f73d0_original.jpg?im_w=720'),
(8, 'https://a0.muscache.com/im/pictures/94453148/c8414a1c_original.jpg?im_w=720'),
(8, 'https://a0.muscache.com/im/pictures/94453320/9ea9c1d7_original.jpg?im_w=720'),
(8, 'https://a0.muscache.com/im/pictures/94453357/8c7f7537_original.jpg?im_w=720'),
(9, 'https://a0.muscache.com/im/pictures/8e7a0dcd-1a7c-4c5c-8c45-d36a38b7e8b6.jpg?im_w=720'),
(9, 'https://a0.muscache.com/im/pictures/75b0f3a7-bcc5-4e5e-9191-5a97d5c0c543.jpg?im_w=720'),
(9, 'https://a0.muscache.com/im/pictures/5da5c1a2-5f5c-4c4d-bc9e-b9a9b2d2c957.jpg?im_w=720'),
(9, 'https://a0.muscache.com/im/pictures/c1117e31-7b65-4b0a-a2d6-daf8e2a6b9a6.jpg?im_w=720'),
(9, 'https://a0.muscache.com/im/pictures/3d0945d3-a01b-4c14-aad2-1cbcbdd67e2f.jpg?im_w=720'),
(10, 'https://a0.muscache.com/im/pictures/5f5b5aa5-b659-4068-89a2-8dd05540e4c4.jpg?im_w=720'),
(10, 'https://a0.muscache.com/im/pictures/70b8fdd5-5b9e-4e71-bbd7-d15e20cc3f3c.jpg?im_w=720'),
(10, 'https://a0.muscache.com/im/pictures/8c76d6dd-4a4e-4f2b-9c59-48d81e7e0d61.jpg?im_w=720'),
(10, 'https://a0.muscache.com/im/pictures/b01a8b7e-e6a2-4a31-a00e-4f4c9af0ab2b.jpg?im_w=720'),
(10, 'https://a0.muscache.com/im/pictures/f50ea91b-3d97-4ae8-8a36-b3704c29a2e2.jpg?im_w=720');



						  
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



UPDATE test.media
	SET image_url='/public/images/0d93e337-c49c-4bf5-83f4-982cb9f2e132.jpg'
	WHERE id=1;
UPDATE test.media
	SET image_url='/public/images/661bf5d6-5f89-4ab6-8397-86e1002f2c2d.jpg'
	WHERE id=2;
UPDATE test.media
	SET image_url='/public/images/5c9897c0-271e-4982-8392-da12c6ba373a.jpg'
	WHERE id=3;
UPDATE test.media
	SET image_url='/public/images/79fb2c80-bf4d-4a7e-8f66-9011fb14d814.jpg'
	WHERE id=4;
UPDATE test.media
	SET image_url='/public/images/c7a534fc-a289-4ca0-862b-282bad0b3487.jpg'
	WHERE id=5;
UPDATE test.media
	SET image_url='/public/images/3efc8fc3-0d9b-4ae3-a4ad-5acd2af63023.jpg'
	WHERE id=6;
UPDATE test.media
	SET image_url='/public/images/9e3f7acd-ca97-43fb-ab77-3e8284cbe489.jpg'
	WHERE id=7;
UPDATE test.media
	SET image_url='/public/images/bda69a7d-fd27-4407-8370-e891bb5338aa.jpg'
	WHERE id=8;
UPDATE test.media
	SET image_url='/public/images/67f7d021-b98f-4fa5-af13-f4aa13a38fd1.jpg'
	WHERE id=9;
UPDATE test.media
	SET image_url='/public/images/fe8e1eab-bb75-4cb9-a735-64d2c74120d7.jpg'
	WHERE id=10;
UPDATE test.media
	SET image_url='/public/images/c3fa3c40-4c21-4775-a478-599198f1979f.jpg'
	WHERE id=11;
UPDATE test.media
	SET image_url='/public/images/809ca1df-4009-4c7d-bc76-700ced9610ba.jpg'
	WHERE id=12;
UPDATE test.media
	SET image_url='/public/images/3ae268be-2695-4d3a-8b69-39c2178c7d08.jpg'
	WHERE id=13;
UPDATE test.media
	SET image_url='/public/images/74da68ea-4ffc-49c4-ba76-c2b0817b6543.jpg'
	WHERE id=14;
UPDATE test.media
	SET image_url='/public/images/40ab55f2-c0bf-4aee-8370-61d1044f5ec7.jpg'
	WHERE id=15;
UPDATE test.media
	SET image_url='/public/images/57e96162-6804-4773-bb59-dd5ca8e69e21.jpg'
	WHERE id=16;
UPDATE test.media
	SET image_url='/public/images/41a530cd-f0ea-4716-bf6c-9e4fd997804d.jpg'
	WHERE id=17;
UPDATE test.media
	SET image_url='/public/images/e352de89-252f-436d-98ce-32517d8ffddf.jpg'
	WHERE id=18;
UPDATE test.media
	SET image_url='/public/images/44c4aaf6-3608-4f3c-8a2d-4318e9e47430.jpg'
	WHERE id=19;
UPDATE test.media
	SET image_url='/public/images/7ea52b34-8177-45ab-b5ad-d1cb83b6f006.jpg'
	WHERE id=20;
UPDATE test.media
	SET image_url='/public/images/bfabec98-9710-4b36-a579-25016adac550.jpg'
	WHERE id=21;
UPDATE test.media
	SET image_url='/public/images/2517c68d-471b-44d0-9a38-726b808b53cd.jpg'
	WHERE id=22;
UPDATE test.media
	SET image_url='/public/images/0118d9cd-6016-44e9-8df5-315b22a34049.jpg'
	WHERE id=23;
UPDATE test.media
	SET image_url='/public/images/55e7f559-f6b7-46b1-8d1d-184d32bf7fae.jpg'
	WHERE id=24;
UPDATE test.media
	SET image_url='/public/images/d1c3be0e-b743-4826-bcf7-83acb196a493.jpg'
	WHERE id=25;
UPDATE test.media
	SET image_url='/public/images/cfa8c22b-9ed7-4f02-b7a7-98919af561d6.jpeg'
	WHERE id=26;
UPDATE test.media
	SET image_url='/public/images/eb90c3e5-5a0a-4ffa-9c5d-b6485d6fba7a.jpg'
	WHERE id=27;
UPDATE test.media
	SET image_url='/public/images/e5536d36-502e-4214-82d4-8d092993216a.jpg'
	WHERE id=28;
UPDATE test.media
	SET image_url='/public/images/325b7fdd-75d2-412d-8576-f8eb2a97d207.jpg'
	WHERE id=29;
UPDATE test.media
	SET image_url='/public/images/58509597-2070-49ca-91b6-241408820b6d.jpg'
	WHERE id=30;
UPDATE test.media
	SET image_url='/public/images/482d0da5-502d-46b7-853b-687c56bc3e99.jpeg'
	WHERE id=31;
UPDATE test.media
	SET image_url='/public/images/1085f5c3-c0ab-4516-b917-720f2d9da76f.jpg'
	WHERE id=32;
UPDATE test.media
	SET image_url='/public/images/9d07887f-944c-4d23-a2c9-570984d9c977.jpeg'
	WHERE id=33;
UPDATE test.media
	SET image_url='/public/images/b9ecd6c0-60ce-4f13-b1bc-f9168ce4a29b.jpeg'
	WHERE id=34;
UPDATE test.media
	SET image_url='/public/images/f7994e20-9632-49ac-80fd-06db2fc9b525.jpeg'
	WHERE id=35;
UPDATE test.media
	SET image_url='/public/images/011e1f9f-8a09-42f2-bf16-ea339d46b3de.jpg'
	WHERE id=36;
UPDATE test.media
	SET image_url='/public/images/9fd6ab9a-2d6b-4ca5-8ded-017cf2b1e009.jpg'
	WHERE id=37;
UPDATE test.media
	SET image_url='/public/images/49a12507-54e7-4bc5-a547-4a4706fea1e5.jpg'
	WHERE id=38;
UPDATE test.media
	SET image_url='/public/images/cf2529cc-2f2c-438d-a705-b1c805fc0091.jpg'
	WHERE id=39;
UPDATE test.media
	SET image_url='/public/images/1631c1e2-bcc6-417a-9bc0-3218fe8ef288.jpg'
	WHERE id=40;
UPDATE test.media
	SET image_url='/public/images/1feb61aa-9dbf-42a9-b125-62ea5d1682d3.jpg'
	WHERE id=41;
UPDATE test.media
	SET image_url='/public/images/a67721b2-b7ef-4861-8fd5-cb10ad3f3512.jpg'
	WHERE id=42;
UPDATE test.media
	SET image_url='/public/images/72c9bcec-d23b-4546-a49a-25242553513c.jpg'
	WHERE id=43;
UPDATE test.media
	SET image_url='/public/images/323124d2-b5b5-4c2c-83aa-70b5995d774a.jpg'
	WHERE id=44;
UPDATE test.media
	SET image_url='/public/images/0749b996-3aae-4fee-b89a-ddecbdc5bf1c.jpg'
	WHERE id=45;
UPDATE test.media
	SET image_url='/public/images/47a239d9-3739-4f32-ae97-3c706ec23d7e.jpg'
	WHERE id=46;
UPDATE test.media
	SET image_url='/public/images/4d1a2af5-d66f-43a9-82b5-e7750cf47058.jpg'
	WHERE id=47;
UPDATE test.media
	SET image_url='/public/images/6ca8be94-c7db-4227-a034-4147f17eefbf.jpg'
	WHERE id=48;
UPDATE test.media
	SET image_url='/public/images/0eb171a3-2862-40d8-bf11-2ee088e39ff4.jpg'
	WHERE id=49;
UPDATE test.media
	SET image_url='/public/images/8fc71eb7-1f86-4982-8ec0-d905789ae6be.jpg'
	WHERE id=50;
                 
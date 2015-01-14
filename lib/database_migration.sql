drop table if exists tracks, tags, tag_assignation, channels, users, irc_posts;

create table tracks (
	track_id INT NOT NULL UNIQUE, 
	name VARCHAR(255), 
	url VARCHAR(255), 
	provider VARCHAR(255), 
	PRIMARY KEY (track_id)
);

create table tags (
	tag_id INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(255) UNIQUE, 
	quantity INT,
	PRIMARY KEY (tag_id)
);

create table tag_assignation (
	track_id INT, 
	tag_id INT);

create table channels (
	channel_id INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(255) UNIQUE, 
	quantity INT,
	PRIMARY KEY (channel_id)
);

create table users (
	user_id INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(255) UNIQUE, 
	quantity INT,
	PRIMARY KEY (user_id)
);

create table irc_posts (
	track_id INT, 
	channel_id INT, 
	user_id INT,
	date TIMESTAMP);

insert into tracks (track_id, name, provider, url) 
	SELECT id, title, type, url 
		FROM playbot;

insert into users (name) 
	SELECT DISTINCT sender_irc 
		FROM playbot_chan;

insert into channels (name) 
	SELECT DISTINCT chan 
		FROM playbot_chan;

insert into tags (name) 
	SELECT DISTINCT tag 
		FROM playbot_tags;

insert into tag_assignation (track_id, tag_id)
	SELECT id, tag_id
		FROM playbot_tags
                LEFT JOIN tags
                  ON playbot_tags.tag = tags.name;

alter table playbot_chan convert to character set utf8 collate utf8_general_ci;

insert into irc_posts (track_id, channel_id, user_id, date) 
	SELECT content, channel_id, user_id, date 
		FROM playbot_chan
                LEFT JOIN channels
                  ON playbot_chan.chan = channels.name
                LEFT JOIN users
                  ON playbot_chan.sender_irc = users.name;


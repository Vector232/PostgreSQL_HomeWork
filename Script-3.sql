create table if not exists Genre(
	id SERIAL primary key,
	name VARCHAR(60) not null
);

create table if not exists Artist(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	genre_id INTEGER not null references Genre(id)
);

create table if not exists Album(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	artist_id INTEGER not null references Artist(id)
);

create table if not exists Compilation(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	release_date DATE
);

create table if not exists Track(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	duration TIME,
	album_id INTEGER unique not null references Album(id),
	compilation_id INTEGER not null references Compilation(id)
);



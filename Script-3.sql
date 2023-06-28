create table if not exists Genres(
	id SERIAL primary key,
	name VARCHAR(60) unique not null
);

create table if not exists Artists(
	id SERIAL primary key,
	name VARCHAR(60) not null
);

create table if not exists Albums(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	release_date DATE check (release_date > date '1900-01-01')
);

create table if not exists Compilations(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	release_date DATE check (release_date > date '1900-01-01')
);

create table if not exists Tracks(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	duration INTEGER check (duration > 0),
	albums_id INTEGER not null references Albums(id)
);

create table if not exists Genres_Artists(
	genres_id INTEGER not null references Genres(id),
	artists_id INTEGER not null references Artists(id),
	constraint genres_artists_id primary key (genres_id, artists_id)
);

create table if not exists Artists_Albums(
	artists_id INTEGER not null references Artists(id),
	albums_id INTEGER not null references Albums(id),
	constraint artists_albums_id primary key (artists_id, albums_id)
);

create table if not exists Compilations_Tracks(
	compilations_id INTEGER not null references Compilations(id),
	tracks_id INTEGER not null references Tracks(id),
	constraint compilations_tracks_id primary key (compilations_id, tracks_id)
);




-- התראה (מס' התראה, מס' פרופיל, תוכן, נקראה/לא נקראה)
create table Notification (
	notification_id number(9) primary key,
	profile_id number(9) foreign key references profile(profile_id)
	content varchar(256) not null,
	watched bool not null
);

-- בקשת חברות (מס' בקשה, מס' פרופיל 1, מס' פרופיל 2, אושרה/לא אושרה)
create table FriendshipRequest (
	requ_id number(9) primary key,
	requester_id number(9) foreign key references profile(profile_id),
	reciever_id *** foreign key references profile(profile_id),
	approved bool
);

-- הצעת חברות (מס' הצעה, מס' פרופיל 1, מס' פרופיל 2)
create table FriendshipSuggestion (
	suggestionID number(9) primary key,
	recieverID number(9) foreign key references profile(profile_id),
	offerID number(9) foreign key references profile(profile_id)
);
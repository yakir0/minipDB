import random

insert_query = 'INSERT INTO FriendshipSuggestion (suggestionid, recieverid, offerid) VALUES (%d, %d, %d);\n'

def createInsertQuery(rows=20_000):
  with open("insertQuery.sql","w") as SQL_file:
    for i in range(rows):
      SQL_file.write(insert_query % (i, random.randint(0, 9999), random.randint(0, 9999)))

createInsertQuery()


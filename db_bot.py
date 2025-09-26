import json
from openai import OpenAI
import os
import mysql.connector
from time import time

print("running db_bot.py")

fdir = os.path.dirname(__file__)
def getPath(fname):
    return os.path.join(fdir, fname)

setupSqlPath = getPath("setup.sql")
setupSqlDataPath = getPath("setupData.sql")
with (open(setupSqlPath) as setupSqlFile, open(setupSqlDataPath) as setupSqlDataFile):
    setupSqlScript = setupSqlFile.read()
    setupSQlDataScript = setupSqlDataFile.read()

def exec_script(cursor, script: str):
    cursor.execute(script)
    # Consume all result sets produced by the script
    while True:
        if cursor.with_rows:
            cursor.fetchall()
        if not cursor.nextset():
            break

conn = mysql.connector.connect(host='127.0.0.1', user='root', password='password')
cursor = conn.cursor()
exec_script(cursor, setupSqlScript) # setup tables and keys
print("created tables")
exec_script(cursor, setupSQlDataScript) # add data
print("added demo data")
conn.commit()

def runSql(query):
    cursor.execute(query)
    rows = cursor.fetchall()
    return rows

# OPENAI
configPath = getPath("config.json")
with open(configPath) as configFile:
    config = json.load(configFile)

openAiClient = OpenAI(api_key = config["openaiKey"])
openAiClient.models.list() # check if the key is valid (update in config.json)

def getChatGptResponse(prompt):
    systemMessage = f"""
        You are part of a natural language interface for a MySQL database at a Chinese 
        restaurant. The user will ask a question in natural language related to the 
        data in the database, and you must respond with MySQL syntax that answers it. 
        Your output will be fed directly into a MySQL cursor object in python to be 
        executed, so you MUST respond with only MySQL syntax and nothing else. The one
        exception to this is if the user's question is irrelevant or unrelated to the 
        data in the database; in this case return only the word "REFUSED" in all caps.

        Follow the pattern in this example, delineated by ampersands (&):
        &&&&&&&&&&
            User: Which five dishes generated the most revenue between 2025-09-25 and 
                2025-10-01 (inclusive)?
            Assistant:
                SELECT
                    d.dish_id,
                    d.name,
                    SUM(od.quantity)                    AS units_sold,
                    ROUND(SUM(od.quantity * d.price),2) AS revenue
                FROM `Order` AS o
                JOIN OrderDish AS od  ON od.order_id = o.order_id
                JOIN Dish      AS d   ON d.dish_id  = od.dish_id
                WHERE o.time >= '2025-09-25' 
                AND o.time <  '2025-10-02'  -- end-exclusive to include 10/01
                GROUP BY d.dish_id, d.name
                ORDER BY revenue DESC
                LIMIT 5;
        &&&&&&&&&&

        To understand the data available to you, here is the setup SQL script that was
        used to create the database, again delineated by ampersands (&):
        &&&&&&&&&&
        {setupSqlScript}
        &&&&&&&&&&
        """

    stream = openAiClient.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": systemMessage},
            {"role": "user", "content": prompt}
        ],
        stream=True,
    )

    responseList = []
    for chunk in stream:
        if chunk.choices[0].delta.content is not None:
            responseList.append(chunk.choices[0].delta.content)

    result = "".join(responseList)
    return result

def sanitizeForJustSql(value):
    gptStartSqlMarker = "```sql"
    gptEndSqlMarker = "```"
    if gptStartSqlMarker in value:
        value = value.split(gptStartSqlMarker)[1]
    if gptEndSqlMarker in value:
        value = value.split(gptEndSqlMarker)[0]

    return value

print()
prompt = input("Prompt: ")
print()
while (prompt.lower() != 'exit'):
    try:
        sqlResponse = getChatGptResponse(prompt)
        if sqlResponse.strip() == "REFUSED":
            print("Sorry, that request was refused. Please try again.")
        else:
            sqlResponse = sanitizeForJustSql(sqlResponse)
            print("ChatGPT Response:")
            print(sqlResponse)
            print()
            queryResponse = str(runSql(sqlResponse))
            print("MySQL Response:")
            print(queryResponse)
            print()
    except Exception as e:
        print(e)

    prompt = input("Prompt: ")
    print()

cursor.close()
conn.close()
print("done")

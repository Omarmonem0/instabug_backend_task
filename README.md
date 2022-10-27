# Instabug Challenge


## Setup For Development
Run the following commands to setup the development environment
```bash
docker-compose up
```

## Modules
### Applications Module
#### List
```bash
    - End point for listing all applications in the system.
    - GET: /applications 
    - NOTE chats_count property is not live it will be updated every 1 hour
```

#### Create
```bash
    - End point for creating application in the system.
    - params {"application" : {name: "test name"}}
    - Adds redis key APP-{UUID} and the value is number of chats in this application.
    - POST: /applications 
```

#### Show
```bash
    - End point for show specific application in the system.
    - GET: /applications/{UUID}
    - NOTE messages_count property is not live it will be updated every 1 hour
```

#### Update
```bash
    - End point for updating specific application in the system.
    - PATCH: /applications/{UUID}
    - params {"application" : {name: "test name"}}.
```

### Chat Module
#### Create
```bash
     - End point for creating chat associated to specific application.
     - This end point adds a background job to create the chat.
     - Adds redis key APP-{UUID}-{CHAT_NUMBER} and the value is number of messages in this chat.
     - Assigns the chat number from redis key added at creating application.
     - Updates the application chat number in redis
     - POST: /applications/{UUID}/chats
```

#### List
```bash
     - End point for listing all chats in specific application.
     - GET: /applications/{UUID}/chats
```

### Message Module
#### Create
```bash
     - End point for creating message associated to specific chat.
     - This end point adds a background job to create the message.
     - Assigns the message number from redis key added at creating chat.
     - Updates the chat message number in redis
     - Adds the record to elasticsearch index.
     - POST: /applications/{UUID}/chats/{CHAT_NUMBER}/message
     - params {"message" : {message: "test name"}}.
```

#### Search
```bash
     - Search by message body in specific chat and application in elasticsearch.
     - GET: messages/{UUID}/{CHAT_NUMBER}/search
     - params {"message" : "body" }
```

### Show
```bash
     - get messages of specific chat.
     - GET: messages/{UUID}/{CHAT_NUMBER}
```

## Background Jobs
```bash
     1- Background job for updating number of chats for application from redis run every 1 hour.
     2- Background job for updating number of messages for chat from redis run every 1 hour.
```
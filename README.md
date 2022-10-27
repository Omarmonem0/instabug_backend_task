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
```

#### Create
```bash
    - End point for creating application in the system.
    - params {"application" : {name: "test name"}}
    - Adding redis key APP-{UUID} and the value is number of chats in this application.
    - POST: /applications 
```

#### Show
```bash
    - End point for show specific application in the system.
    - GET: /applications/{UUID}
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
     - This end point add a background job to create the chat.
     - Adding redis key APP-{UUID}-{CHAT_NUMBER} and the value is number of messages in this chat.
     - Assign the chat number from redis key added at creating application.
     - Update the application chat number in redis
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
     - This end point add a background job to create the message.
     - Assign the message number from redis key added at creating chat.
     - Update the chat message number in redis
     - Add the record to elasticsearch index.
     - POST: /applications/{UUID}/chats/{CHAT_NUMBER}/message
     - params {"message" : {message: "test name"}}.
```

#### Search
```bash
     - Search by message body in specific chat and application in elasticsearch.
     - GET: /applications/{UUID}/chats/{CHAT_NUMBER}/message
     - params {"message" : {message: "test name"}}.
```

## Background Jobs
```bash
     1- Background job for updating number of chats for application from redis run every 1 hour.
     2- Background job for updating number of messages for chat from redis run every 1 hour.
```
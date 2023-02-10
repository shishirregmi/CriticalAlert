const express = require('express');
const app = express();
const cors = require("cors");
app.use(cors());
const server = require('http').createServer(app);
const io = require('socket.io')(server, {
  cors: {
    origin: "http://localhost:44334",
    methods: ["GET", "POST"],
  },
});
const port = 3000;

const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.post('/post', (req, res) => {
  const data = req.body;
  // Emit the data to the client
  io.emit('post', data);
  res.send({ status: 'success' });
});

server.listen(port, () => {
  console.log(`Server listening at port ${port}`);
});

// Listen for a connection event from the client
io.on('connection', socket => {
  console.log('Client connected');
  
  // Listen for an event from the client
  socket.on('messageFromClient', data => {
    console.log(data);
    
    // Emit an event to the client
    socket.emit('messageFromServer', { message: 'Hello from the server!' });
  });
  
  // Listen for a disconnect event from the client
  socket.on('disconnect', () => {
    console.log('Client disconnected');
  });
});

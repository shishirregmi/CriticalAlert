const connectionOptions = {
    "force new connection": true,
    "reconnectionAttempts": "Infinity",
    "timeout": 10000,
    "transports": ["websocket"]
};
const socket = io('http://localhost:3000', connectionOptions);

socket.on('connect', () => {
    console.log('Connected to server');

    // Emit an event to the server
    socket.emit('messageFromClient', { message: 'Hello from the client!' });

    // Listen for an event from the server
    socket.on('messageFromServer', data => {
    });
});

socket.on('disconnect', () => {
    console.log('Disconnected from server');
});

socket.on('post', data => {
    ShowAlert(data);
});

function ShowAlert(data) {
    Swal.fire({
        title: 'Emergency!',
        text: data.requestType,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'View Patient information!'
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire(
                'Deleted!',
                'Your file has been deleted.',
                'success'
            )
        }
    })
}
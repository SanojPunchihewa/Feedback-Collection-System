import ballerina/http;
import ballerina/io;
import ballerina/log;

http:Client clientEndpoint = new("http://localhost:9090");

public function main() {

    io:println("Welcome to our Contact Us Page!");
    
    // read user's choice
    string name = io:readln("Enter your name: ");
    string email = io:readln("Enter your email: ");
    string message = io:readln("Enter your message: ");

    http:Request req = new;

    // Set the JSON payload to the message to be sent to the endpoint.
    json jsonMsg = { name: name, email: email, message: message };
    req.setJsonPayload(jsonMsg);

    var response = clientEndpoint->post("/feedback/pushData", req);
    if (response is http:Response) {
        var msg = response.getJsonPayload();
        if (msg is json) {
                io:println(msg);
            } else {
                log:printError("Response is not json", err = msg);
            }
    } else {
        log:printError("Invalid response", err = response);
    }
}
import ballerina/http;
import ballerina/log;
import ballerina/time;

listener http:Listener httpListener = new(9090);

// Feedback collection service
@http:ServiceConfig { 
    basePath: "/feedback",
    cors: {
        allowOrigins: ["*"],
        allowHeaders: ["*"]
    }}

service FeedbackCollection on httpListener {
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/pushData"
    }
    resource function updateFeedback(http:Caller caller, http:Request req) {

        var reqPayload = req.getJsonPayload();
        http:Response errResp = new;
        errResp.statusCode = 500;
        if(reqPayload is json){

            var name = reqPayload.name.toString();
            var email = reqPayload.email.toString();
            var message = reqPayload.message.toString();

            // get the current time
            time:Time time = time:currentTime();
            //Format a time to a string of a given pattern.
            string timeStamp = time:format(time, "yyyy-MM-dd::HH:mm");

            string[] values = untaint [timeStamp, name, email, message];

            var response = appendRowToGSheet(values);

            if(response is error){
                errResp.setJsonPayload({"^error":"Appending data to Google Sheets"});
                var err = caller->respond(errResp);
                handleResponseError(err);
                return;
            }else{                
                // Create response message.
                json payload = { status: "Successfully append data"};

                // Send response to the client.
                var err = caller->respond(untaint payload);
                handleResponseError(err);
            }           
            
        } else {
            errResp.setJsonPayload({"^error":"Request payload should be a json."});
            var err = caller->respond(errResp);
            handleResponseError(err);
        }
    }
}

function handleResponseError(error? err) {
    if (err is error) {
        log:printError("Respond failed", err = err);
    }
}
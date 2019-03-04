import gsheets4;
import ballerina/http;
import ballerina/log;
import ballerina/io;
import ballerina/config;

# A valid accessToken for google sheets access.
string accessToken = config:getAsString("ACCESS_TOKEN");
# The client ID for your application.
string clientId = config:getAsString("CLIENT_ID");
# The client secret for your application.
string clientSecret = config:getAsString("CLIENT_SECRET");
# A valid refreshToken for google sheets access.
string refreshToken = config:getAsString("REFRESH_TOKEN");
# Spreadsheet id of the reference google sheet.
string spreadsheetId = config:getAsString("SHEET_ID");
# Sheet name of the reference googlle sheet.
string sheetName = config:getAsString("SHEET_NAME");

# Google Sheets client endpoint declaration with http client configurations.
gsheets4:Client spreadsheetClient = new({
    clientConfig: {
        auth: {
            scheme: http:OAUTH2,
            accessToken: accessToken,
            refreshToken: refreshToken,
            clientId: clientId,
            clientSecret: clientSecret
        }
    }
});

# Appends user feedback details to the spreadsheet.
#
# + return - True on success and error on failure
function appendRowToGSheet(string[] values) returns boolean|error {

    var response = spreadsheetClient->appendRow(spreadsheetId, sheetName, values);
    log:printInfo("Appended user feedback to spreadsheet id: " + spreadsheetId + "; sheet name: "
            + sheetName);
    return response;
}

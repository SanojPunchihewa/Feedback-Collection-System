# Feedback Collection System

A simple feedback collection system made with ballerina, google sheets and a web interface.

## How to run

1. Update the following values in the `ballerina.conf` file
```
ACCESS_TOKEN="access token"
CLIENT_ID="client id"
CLIENT_SECRET="client secret"
REFRESH_TOKEN="refresh token"
SPREADSHEET_ID="spreadsheet id you have extracted from the sheet url"
SHEET_NAME="sheet name of your Goolgle Sheet."
```
Obtain the spreadsheet id by extracting the value between the "/d/" and the "/edit" in the URL of your spreadsheet.

You may visit [Google API Console](https://console.developers.google.com), and follow the instructions to obtain the above tokens.

2. Run the feedback collection service
```
$ ballerina run feedback-service
```

3. Use the client CLI to input feedback
```
$ ballerina run client.bal
```

## TODO

Fix the bug related to CORS when using the web interface to submit data to the feedback service.

## Reference
[Ballerina](https://github.com/ballerina-platform/ballerina-lang)

[Ballerina Module for Google Sheets](https://github.com/wso2-ballerina/module-googlespreadsheet)

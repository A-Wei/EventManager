## Event_Manager

### Welcome
Welcome to `Event Manager`,this toy app is to build a web application similar to Facebook Events, where you can search and show interest of an event,'check-in' and 'check-out' an event in the given time range. e.g can only check in an event 1h before it starts etc.

### Where it might get used
This webapp is designed for workshop, conference, event, class organizers which they can

1. Knwo how many people will join (people showed interest)
2. How many people actually showed up (checked in)
3. Randomly selecting a person from checked-in users to give prizes
4. Analyze your attendents, age, gender, other events they joined.
5. Download the attendance list to follow up for feedback

### Note
Note, for the check-in check-out functionality, prefer to use mobile app to scan QR code which refresh every second. The time hitting the database and the time encoded in QR code should be less than 5s to validate the check in. I will start with check-in and out with simple buttons on web and develop.

### Other features in consideration for version 2
* Admin page for system admin
* Analytics page for event creator
* History page for user to see what events they have joined

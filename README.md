
## Telegram Clone

This is a practice app for me to practise iOS development.


### CHANGELOG

2 Feb 2022:
- Message send handling mechanism done

29 Jan 2022:
- Redesigned Chat view
- Fixed: We get the authenticated user after we sign in as the user, not before. This fixes a crash when logging in.

28 Jan 2022:
- Added "name" to a user's information
- Searching for a user now displays their name in a custom ```UILabel```

26 Jan 2022:
- Username search is working

12 Jan 2022:
- Applied autolayout to chat cells
- Added an extra field, "username", to registration so each user now has a username
- Change user's status to "online" upon logging in

11 Jan 2022:
- You can now sign in as a user
- Changed username textfield to email textfield
- Registering a user now happens before the successful popup appears, not when you tap "OK"

9 Jan 2022:
- Applied Autolayout to login and registration screen
- You can now register a user

5 Jan 2022:
- Drafted out the login screen and registration screen in Storyboard

4 Jan 2022:
- Created Firebase project
- Converted project to a Cocoapods project

1 Jan 2022:
- Added a new ```UITableViewCell``` for Chat cell
- Added Edit button in ```ChatTableViewController```
- Added Compose button in ```ChatTableViewController```

31 Dec 2021:
- Just started with displaying a default view controller on load
